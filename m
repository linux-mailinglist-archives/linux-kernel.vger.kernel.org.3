Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A5B505CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346598AbiDRQyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244634AbiDRQxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:53:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D2C633343
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650300669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AYHM3um6vRYLk4H6WX4rdEi004fqzTD7e3vZ1hx8pX0=;
        b=JMLhdf0ysFjCg/IXPd2xOeP9oecRfNV0oVgEEdkb34GN+GUuf78OlAVThVTSWi22OOL0M1
        ybU2UmIAFyTO8qicF0vocreAtmmOw+RALwBsx3g4U8TRdxEPpZWXMPx50wU+ObC5f2Nawu
        HTZdM+cq071Ck/f0B6XhER7/qhYOY+w=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-8x_qrXjpM0-olhG3EbCtKg-1; Mon, 18 Apr 2022 12:51:08 -0400
X-MC-Unique: 8x_qrXjpM0-olhG3EbCtKg-1
Received: by mail-qv1-f69.google.com with SMTP id o1-20020ad44561000000b0044635418a3cso7674253qvu.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AYHM3um6vRYLk4H6WX4rdEi004fqzTD7e3vZ1hx8pX0=;
        b=vvzgrKxSU4g0kebmOtYpYVFRLjj+LEzcnf1PMXLZiHCm2zZYAsqi3rAslnaozxByQ5
         Qn02NxqFq87iuERKH2VrccS02dukFlsCzL6XIXow0YyE9Oa1H5IM3xNEDz7Tm/zQTD0d
         NAwsST2O43BaCSXQeZwTdk+rc7P+YkaqnKfOrI+G2wWOkdfsYHK2JupW/xre2lBK2YdM
         infaSF6RltPaZbrMngeG+uiglVU74mXgO698XLThY14CjXZXMfZ/0Yu/glWZvJBolsy3
         P9sHf+y2vMQ+wVIzMRaZxHh6yjNgqCEoXjHzHUa1pXz5Lqh/bZWM1MIwvBp5E/y0lzp+
         FFfA==
X-Gm-Message-State: AOAM531P+mnUpnqAgR7dhOQXVDqlIELDXnk5FnRMbC7pRvTZAObbaRtS
        lbd+hc6LvxGx3iwa4HNuSn70+K7KOmmSuW4cob7/08y5VRn9NOSBWrFTaLpA22iCApsQIMnFmVp
        zKOBuN+GRk2fPE+8bXTABw/R4
X-Received: by 2002:a05:6214:1d09:b0:446:6786:6d43 with SMTP id e9-20020a0562141d0900b0044667866d43mr2090183qvd.97.1650300667648;
        Mon, 18 Apr 2022 09:51:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4/OWM3SREH/elaEF+EUpqf1uYOwNTgpuBBVAr2SlDdQqmQcR3jg1W6OV8iuu463jSkvRpWA==
X-Received: by 2002:a05:6214:1d09:b0:446:6786:6d43 with SMTP id e9-20020a0562141d0900b0044667866d43mr2090172qvd.97.1650300667394;
        Mon, 18 Apr 2022 09:51:07 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8670f000000b002e22d9c756dsm7277059qtp.30.2022.04.18.09.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:51:06 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 10/25] objtool: Print data address for "!ENDBR" data warnings
Date:   Mon, 18 Apr 2022 09:50:29 -0700
Message-Id: <762e88d51300e8eaf0f933a5b0feae20ac033bea.1650300597.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650300597.git.jpoimboe@redhat.com>
References: <cover.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a "!ENDBR" warning is reported for a data section, objtool just
prints the text address of the relocation target twice, without giving
any clues about the location of the original data reference:

  vmlinux.o: warning: objtool: dcbnl_netdevice_event()+0x0: .text+0xb64680: data relocation to !ENDBR: dcbnl_netdevice_event+0x0

Instead, print the address of the data reference, in addition to the
address of the relocation target.

  vmlinux.o: warning: objtool: dcbnl_nb+0x0: .data..read_mostly+0xe260: data relocation to !ENDBR: dcbnl_netdevice_event+0x0

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index acf26d273e2f..97026c1b4bd6 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3825,11 +3825,8 @@ static int validate_ibt(struct objtool_file *file)
 			struct instruction *dest;
 
 			dest = validate_ibt_reloc(file, reloc);
-			if (is_data && dest && !dest->noendbr) {
-				warn_noendbr("data ", reloc->sym->sec,
-					     reloc->sym->offset + reloc->addend,
-					     dest);
-			}
+			if (is_data && dest && !dest->noendbr)
+				warn_noendbr("data ", sec, reloc->offset, dest);
 		}
 	}
 
-- 
2.34.1

