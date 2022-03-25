Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968C14E7D7B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiCYTty convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Mar 2022 15:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiCYTtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:49:10 -0400
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33E92296DA;
        Fri, 25 Mar 2022 12:33:01 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 3F1DA20A097D
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Denis Glazkov <d.glazkov@omp.ru>
CC:     Denis Glazkov <d.glazkov@omp.ru>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: [PATCH v2] KEYS: Improve error handling in the script
Thread-Topic: [PATCH v2] KEYS: Improve error handling in the script
Thread-Index: AQHYQHRhOXnmlwunc06tlBqeYDNOag==
Date:   Fri, 25 Mar 2022 18:16:01 +0000
Message-ID: <20220325181550.278067-1-d.glazkov@omp.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.11.212]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MISSING_HEADERS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the `exit` function for error handling entails
a number of problems:

- not a closed file;
- unreleased memory allocated for the certificate;
- non-deleted mapping to vmlinux file.

This patch fixes the listed issues.

Signed-off-by: Denis Glazkov <d.glazkov@omp.ru>

---
Changes in version 2:
- refactored error handling, instead of fixing a single `read_file` function;
- changed the patch subject.

Version 1 was there:
- https://lore.kernel.org/all/20220303081428.12979-1-d.glazkov@omp.ru/

 scripts/insert-sys-cert.c | 51 +++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/scripts/insert-sys-cert.c b/scripts/insert-sys-cert.c
index 8902836c2342..8046682188f3 100644
--- a/scripts/insert-sys-cert.c
+++ b/scripts/insert-sys-cert.c
@@ -101,7 +101,7 @@ static void get_symbol_from_map(Elf_Ehdr *hdr, FILE *f, char *name,
 	s->offset = 0;
 	if (fseek(f, 0, SEEK_SET) != 0) {
 		perror("File seek failed");
-		exit(EXIT_FAILURE);
+		return;
 	}
 	while (fgets(l, LINE_SIZE, f)) {
 		p = strchr(l, '\n');
@@ -251,6 +251,7 @@ static char *read_file(char *file_name, int *size)
 	if (read(fd, buf, *size) != *size) {
 		perror("File read failed");
 		close(fd);
+		free(buf);
 		return NULL;
 	}
 	close(fd);
@@ -277,14 +278,15 @@ int main(int argc, char **argv)
 	char *cert_file = NULL;
 	int vmlinux_size;
 	int cert_size;
-	Elf_Ehdr *hdr;
-	char *cert;
-	FILE *system_map;
+	Elf_Ehdr *hdr = NULL;
+	char *cert = NULL;
+	FILE *system_map = NULL;
 	unsigned long *lsize;
 	int *used;
 	int opt;
 	Elf_Shdr *symtab = NULL;
 	struct sym cert_sym, lsize_sym, used_sym;
+	int ret = EXIT_FAILURE;
 
 	while ((opt = getopt(argc, argv, "b:c:s:")) != -1) {
 		switch (opt) {
@@ -304,20 +306,20 @@ int main(int argc, char **argv)
 
 	if (!vmlinux_file || !cert_file) {
 		print_usage(argv[0]);
-		exit(EXIT_FAILURE);
+		goto finish;
 	}
 
 	cert = read_file(cert_file, &cert_size);
 	if (!cert)
-		exit(EXIT_FAILURE);
+		goto finish;
 
 	hdr = map_file(vmlinux_file, &vmlinux_size);
 	if (!hdr)
-		exit(EXIT_FAILURE);
+		goto finish;
 
 	if (vmlinux_size < sizeof(*hdr)) {
 		err("Invalid ELF file.\n");
-		exit(EXIT_FAILURE);
+		goto finish;
 	}
 
 	if ((hdr->e_ident[EI_MAG0] != ELFMAG0) ||
@@ -325,22 +327,22 @@ int main(int argc, char **argv)
 	    (hdr->e_ident[EI_MAG2] != ELFMAG2) ||
 	    (hdr->e_ident[EI_MAG3] != ELFMAG3)) {
 		err("Invalid ELF magic.\n");
-		exit(EXIT_FAILURE);
+		goto finish;
 	}
 
 	if (hdr->e_ident[EI_CLASS] != CURRENT_ELFCLASS) {
 		err("ELF class mismatch.\n");
-		exit(EXIT_FAILURE);
+		goto finish;
 	}
 
 	if (hdr->e_ident[EI_DATA] != endianness()) {
 		err("ELF endian mismatch.\n");
-		exit(EXIT_FAILURE);
+		goto finish;
 	}
 
 	if (hdr->e_shoff > vmlinux_size) {
 		err("Could not find section header.\n");
-		exit(EXIT_FAILURE);
+		goto finish;
 	}
 
 	symtab = get_symbol_table(hdr);
@@ -349,13 +351,13 @@ int main(int argc, char **argv)
 		if (!system_map_file) {
 			err("Please provide a System.map file.\n");
 			print_usage(argv[0]);
-			exit(EXIT_FAILURE);
+			goto finish;
 		}
 
 		system_map = fopen(system_map_file, "r");
 		if (!system_map) {
 			perror(system_map_file);
-			exit(EXIT_FAILURE);
+			goto finish;
 		}
 		get_symbol_from_map(hdr, system_map, CERT_SYM, &cert_sym);
 		get_symbol_from_map(hdr, system_map, USED_SYM, &used_sym);
@@ -371,7 +373,7 @@ int main(int argc, char **argv)
 	}
 
 	if (!cert_sym.offset || !lsize_sym.offset || !used_sym.offset)
-		exit(EXIT_FAILURE);
+		goto finish;
 
 	print_sym(hdr, &cert_sym);
 	print_sym(hdr, &used_sym);
@@ -382,14 +384,16 @@ int main(int argc, char **argv)
 
 	if (cert_sym.size < cert_size) {
 		err("Certificate is larger than the reserved area!\n");
-		exit(EXIT_FAILURE);
+		goto finish;
 	}
 
+	ret = EXIT_SUCCESS;
+
 	/* If the existing cert is the same, don't overwrite */
 	if (cert_size == *used &&
 	    strncmp(cert_sym.content, cert, cert_size) == 0) {
 		warn("Certificate was already inserted.\n");
-		exit(EXIT_SUCCESS);
+		goto finish;
 	}
 
 	if (*used > 0)
@@ -406,5 +410,16 @@ int main(int argc, char **argv)
 						cert_sym.address);
 	info("Used %d bytes out of %d bytes reserved.\n", *used,
 						 cert_sym.size);
-	exit(EXIT_SUCCESS);
+
+finish:
+	if (cert != NULL)
+		free(cert);
+
+	if (hdr != NULL)
+		munmap(hdr, vmlinux_size);
+
+	if (system_map != NULL)
+		fclose(system_map);
+
+	return ret;
 }
-- 
2.25.1
