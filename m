Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C186500274
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239246AbiDMXWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239045AbiDMXWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:22:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8A8623BC5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649892002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=442epl1h4yre5UcCgCdD+uGW52QoSWlok9Dl9A8mhpY=;
        b=EcXZvyxV4rj0nbLNQLuJ/UaVhQeIsP/vFat6dmPZGPpZ95GRpAKU4gtcP09jjSIRAcH8rm
        nsLqcwS/fqdnRWC0jki9QYHa2rW8wXjN2b8chpMk3CZZde6m0wvIiwWNOcUAo1uClqkiw7
        CO9YdlhwUuszF+FWB0+SnYxJuRdisuA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-NuYlwR1aNVKhDnrzPkU10A-1; Wed, 13 Apr 2022 19:20:01 -0400
X-MC-Unique: NuYlwR1aNVKhDnrzPkU10A-1
Received: by mail-qk1-f198.google.com with SMTP id bp31-20020a05620a459f00b00699fabcc554so2155404qkb.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=442epl1h4yre5UcCgCdD+uGW52QoSWlok9Dl9A8mhpY=;
        b=tgg14FLq+hWN+eclUaux1NGcx4yN0mT8SX9XA0M6D+IcvPxhDOVKFe1BMjGkZtE+2I
         BkBJJwz5I4sdxAVDKF2AXnh+wEujjpax+gcYmzeb6mqT0eZyZJBic/xj6QLesRCOmbwu
         6tFVnDkZSjYzYwcwGx8FwAXuyzxTsGgeEY9B2zZaKaaRgXRoGnr5nskJ/aDDw6YgxjU8
         HIzNOcMnqFZghm/aUYzzxEdvhiqTdMkxyUoGxlnnWcLVLiIQjEnm+SsGo95YfXBdBq3+
         K9o4ehLjbf2/23NZ+bVfS1gMMxvwSdcB1iqtCfxggWq4MUafDRtBQUko9UpB/EtpdzMS
         KcZQ==
X-Gm-Message-State: AOAM532S1RRy4MuGRbwGVBVrVP5tcn3L00eU2Uazrwx2/CCbA8uAXoAo
        w7u5AIpfJtqdbSSC5sNU/bC9nwmvzsQ8NI0gxcpBl9wpsOZgrD1H0Ml4sv13dAUwU0mIpdqT2Ni
        7pquelQC7PGJzVnDo+TuNXR21
X-Received: by 2002:a05:620a:1906:b0:67b:3ac1:8f72 with SMTP id bj6-20020a05620a190600b0067b3ac18f72mr8605945qkb.478.1649892000370;
        Wed, 13 Apr 2022 16:20:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVjaX8Z+d6CpU3KR7d7sRB46cwStUMLaVCHg9wMRz1XpHcd0PgUrCUc2AXRS7im+ErFl3HZw==
X-Received: by 2002:a05:620a:1906:b0:67b:3ac1:8f72 with SMTP id bj6-20020a05620a190600b0067b3ac18f72mr8605933qkb.478.1649892000134;
        Wed, 13 Apr 2022 16:20:00 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id b20-20020a05622a021400b002f08f5658a2sm193925qtx.68.2022.04.13.16.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:19:59 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 02/18] objtool: Support data symbol printing
Date:   Wed, 13 Apr 2022 16:19:37 -0700
Message-Id: <097057f88605aa67b0e3ec573fcf394ae7ac4d6f.1649891421.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649891421.git.jpoimboe@redhat.com>
References: <cover.1649891421.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For data relocations to missing ENDBR, it will be useful in some cases
to print the data symbol + offset.  Add support for that.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/include/objtool/warn.h | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
index 802cfda0a6f6..dab0dda7c617 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -17,16 +17,19 @@ extern const char *objname;
 
 static inline char *offstr(struct section *sec, unsigned long offset)
 {
-	struct symbol *func;
-	char *name, *str;
+	bool is_text = (sec->sh.sh_flags & SHF_EXECINSTR);
+	struct symbol *sym = NULL;
 	unsigned long name_off;
+	char *name, *str;
+
+	if (is_text)
+		sym = find_func_containing(sec, offset);
+	if (!sym)
+		sym = find_symbol_containing(sec, offset);
 
-	func = find_func_containing(sec, offset);
-	if (!func)
-		func = find_symbol_containing(sec, offset);
-	if (func) {
-		name = func->name;
-		name_off = offset - func->offset;
+	if (sym) {
+		name = sym->name;
+		name_off = offset - sym->offset;
 	} else {
 		name = sec->name;
 		name_off = offset;
@@ -34,8 +37,8 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 
 	str = malloc(strlen(name) + 20);
 
-	if (func)
-		sprintf(str, "%s()+0x%lx", name, name_off);
+	if (sym)
+		sprintf(str, "%s%s+0x%lx", name, is_text ? "()" : "", name_off);
 	else
 		sprintf(str, "%s+0x%lx", name, name_off);
 
-- 
2.34.1

