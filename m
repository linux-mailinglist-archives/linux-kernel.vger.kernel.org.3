Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE1D505CCB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346539AbiDRQx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346477AbiDRQxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:53:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0601F32987
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650300664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Isq+zk2J624eZUtPJ7xeNC7xKsJH08BlurzTHOz018=;
        b=dmULEkPXkZ+44rHlwvw+WlRgVYk8tFZPVfkvSb8SWLoiPcBDjtl1lXM6P6N6a4qNdV54x0
        irEuQ81UPeL3EjzXX7R526S/qd125Db8vivNvSZok0/gnYHsJRLCReMzVpchu97TcFy2lB
        xIz+/cGVz0GN6KzLrTs97vL23IXDle0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-s_38F6OSNuet_ZOU4n_sLA-1; Mon, 18 Apr 2022 12:51:00 -0400
X-MC-Unique: s_38F6OSNuet_ZOU4n_sLA-1
Received: by mail-qv1-f70.google.com with SMTP id fw9-20020a056214238900b0043522aa5b81so12520909qvb.21
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Isq+zk2J624eZUtPJ7xeNC7xKsJH08BlurzTHOz018=;
        b=wV0zMV8BEmbaWSja5p6aPQjW/yaDYD568GkhW/1HzYVf7VK1yVHUwga3KDVFJMeB7y
         J4nctN4g7zqyyWRtfP11xeRCoHddtx2urFffqUo7qJxzZAOzCtv0JLPBvo0dBulnMZR9
         vAPV50KQRInT96FmfAztda/p4sw93x38Zd4LgluvumKeSJmZZP5D7uvIRcZGrqYiBrny
         HytyAb7GY8ggt5MaeH9YQl+MjLtmyfR2PX5BQqaaiMiR1CG53UvDzxmFAxTPdHzJVAos
         UrzJHD8iDa2IlKt5vnmK6RNWfCQXEdbIxtpA8bS+KBSljI+OU8McMpOkXbWXPiO9AkCp
         L41w==
X-Gm-Message-State: AOAM531qfaIaaPsQUBWaItv8Kk5l9M0o4IsJwg2g2tnGMhcMQEFMZ+cl
        0v/ATPcmo7avTyOCc3NXMdeKpORZeFvG+7x9YSMFeyva+Ixsm/WUhT6YMY86sYNMHGJX+B6p8bZ
        HoE9pdMir50BnfBj5lVSQekSx
X-Received: by 2002:a05:6214:20e5:b0:446:393a:7a92 with SMTP id 5-20020a05621420e500b00446393a7a92mr8548541qvk.28.1650300659848;
        Mon, 18 Apr 2022 09:50:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYc+FvYh1h+v+kvPfKOugyUq+1wP14a+dUTKuPyQe3QRiLPbOn6dwC9bFi1bx0St6bGBBWkw==
X-Received: by 2002:a05:6214:20e5:b0:446:393a:7a92 with SMTP id 5-20020a05621420e500b00446393a7a92mr8548531qvk.28.1650300659602;
        Mon, 18 Apr 2022 09:50:59 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8670f000000b002e22d9c756dsm7277059qtp.30.2022.04.18.09.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:50:59 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 05/25] x86/uaccess: Add ENDBR to __put_user_nocheck*()
Date:   Mon, 18 Apr 2022 09:50:24 -0700
Message-Id: <207f02177a23031091d1a608de6049a9e5e8ff80.1650300597.git.jpoimboe@redhat.com>
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

The __put_user_nocheck*() inner labels are exported, so in keeping with
the "allow exported functions to be indirectly called" policy, add
ENDBR.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/lib/putuser.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index ecb2049c1273..b7dfd60243b7 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -48,6 +48,7 @@ SYM_FUNC_START(__put_user_1)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
 SYM_INNER_LABEL(__put_user_nocheck_1, SYM_L_GLOBAL)
+	ENDBR
 	ASM_STAC
 1:	movb %al,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -62,6 +63,7 @@ SYM_FUNC_START(__put_user_2)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
 SYM_INNER_LABEL(__put_user_nocheck_2, SYM_L_GLOBAL)
+	ENDBR
 	ASM_STAC
 2:	movw %ax,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -76,6 +78,7 @@ SYM_FUNC_START(__put_user_4)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
 SYM_INNER_LABEL(__put_user_nocheck_4, SYM_L_GLOBAL)
+	ENDBR
 	ASM_STAC
 3:	movl %eax,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -90,6 +93,7 @@ SYM_FUNC_START(__put_user_8)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
 SYM_INNER_LABEL(__put_user_nocheck_8, SYM_L_GLOBAL)
+	ENDBR
 	ASM_STAC
 4:	mov %_ASM_AX,(%_ASM_CX)
 #ifdef CONFIG_X86_32
-- 
2.34.1

