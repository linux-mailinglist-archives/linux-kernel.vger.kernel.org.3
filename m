Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279904CBE3E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbiCCM5i convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Mar 2022 07:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiCCM5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:57:35 -0500
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21CE186218;
        Thu,  3 Mar 2022 04:56:46 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru AB8C820F1773
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Denis Glazkov <d.glazkov@omp.ru>
To:     Denis Glazkov <d.glazkov@omp.ru>
CC:     "dhowells@redhat.com" <dhowells@redhat.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "mkayaalp@linux.vnet.ibm.com" <mkayaalp@linux.vnet.ibm.com>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "zohar@linux.vnet.ibm.com" <zohar@linux.vnet.ibm.com>
Subject: [PATCH v2] KEYS: fix memory leaks when reading certificate
Thread-Topic: [PATCH v2] KEYS: fix memory leaks when reading certificate
Thread-Index: AQHYLv4hXvGLTwdWtEaXm/lsw1BmKA==
Date:   Thu, 3 Mar 2022 12:56:42 +0000
Message-ID: <20220303125627.93930-1-d.glazkov@omp.ru>
References: <20220303081428.12979-1-d.glazkov@omp.ru>
In-Reply-To: <20220303081428.12979-1-d.glazkov@omp.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.11.146]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `exit()` function usage produce possible memory leaks. This
patch removes the use of the `exit()` function and adds memory
free in case of a negative scenarios.

Fixes: c4c361059585 ("KEYS: Reserve an extra certificate symbol for inserting without recompiling")
Signed-off-by: Denis Glazkov <d.glazkov@omp.ru>
---
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
