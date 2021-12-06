Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F40F4697CB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244941AbhLFOJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:09:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34570 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244907AbhLFOJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:09:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22413B810D8;
        Mon,  6 Dec 2021 14:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C81BC341C1;
        Mon,  6 Dec 2021 14:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638799528;
        bh=Wm/pv0sWf2JDMBriDDQEygaKITi3QVZOeKNtHO8HurM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UVTAgvefmsvQYAIka2UrnpX7+a1z+v+r68LbAf5unMfact9jx41U6ydbAv6WIQOWb
         COQPRxW7YEUS+8k5VfcuUYopZPCNg2AS+XvUhGYsi20ARwchofx+VM6RqvpywrJkPA
         6t7b0baZ+3b+/3OGG4/DL/34MY/tqXSkQR19SDySAfn9ZzTReudBEQZS1aSLYatxIk
         7KvBlrzTwnSe6ZsYCUcDwd7HXEx//AMLPXwQo/ab4iycwMIsXv/2YrKHRwYokAy+Vz
         inbJ2I9B4uZnhmIxSwchy+6oeRtRA36CeaBokUtDQBhRsr3k37xV7+k7eC6F/EtQfi
         Qw918gRTdTuiA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 03/19] kallsyms: use the correct buffer size for symbols
Date:   Mon,  6 Dec 2021 15:02:57 +0100
Message-Id: <20211206140313.5653-4-ojeda@kernel.org>
In-Reply-To: <20211206140313.5653-1-ojeda@kernel.org>
References: <20211206140313.5653-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com>

The buffered name size should be larger than `KSYM_NAME_LEN`, otherwise
we cannot tell whether the size of a symbol name is too long.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/kallsyms.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 72ba0fe4e43b..0e37c19d84af 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -27,6 +27,9 @@
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
 
+#define _stringify_1(x)	#x
+#define _stringify(x)	_stringify_1(x)
+
 #define KSYM_NAME_LEN		512
 
 struct sym_entry {
@@ -197,15 +200,15 @@ static void check_symbol_range(const char *sym, unsigned long long addr,
 
 static struct sym_entry *read_symbol(FILE *in)
 {
-	char name[500], type;
+	char name[KSYM_NAME_LEN+1], type;
 	unsigned long long addr;
 	unsigned int len;
 	struct sym_entry *sym;
 	int rc;
 
-	rc = fscanf(in, "%llx %c %499s\n", &addr, &type, name);
+	rc = fscanf(in, "%llx %c %" _stringify(KSYM_NAME_LEN) "s\n", &addr, &type, name);
 	if (rc != 3) {
-		if (rc != EOF && fgets(name, 500, in) == NULL)
+		if (rc != EOF && fgets(name, KSYM_NAME_LEN + 1, in) == NULL)
 			fprintf(stderr, "Read error or end of file.\n");
 		return NULL;
 	}
-- 
2.34.0

