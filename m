Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F199505CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346551AbiDRQyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346476AbiDRQxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:53:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB5D3326E7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650300663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sKtm4nbSU3FWhhvlPNHt662yt7zgfxklNVpsEjzLR6E=;
        b=EShWZSnMbmoP9zXkNurrkTdUPw/fwElpIkm/g/wzinO6NrsoaRLip7LIWg1DsT7JfuN3V6
        h7Wjzqk6N0OmfUoCzJp7Nm/TL18FjQo36o8IEnyETbGy7lDuRMzF4lOakBQamMoF6IvVB/
        hMtldqZJVendGQ46icNhQxMI85oBUWg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-G_vKqorEMwO5nZJN8is1sQ-1; Mon, 18 Apr 2022 12:51:02 -0400
X-MC-Unique: G_vKqorEMwO5nZJN8is1sQ-1
Received: by mail-qk1-f198.google.com with SMTP id t3-20020a05620a034300b0069e60a0760cso5644514qkm.20
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sKtm4nbSU3FWhhvlPNHt662yt7zgfxklNVpsEjzLR6E=;
        b=lgTPOdXp30keDQUzoLEMuIMZLSS2MC2+0f21vhp5cGNcKfGC2uTdlya2IkRApHIvE/
         j6rIlCYCs/QZjqNpHrfbUgTacR/VzUXARVHrRbPLrLxRiCIgr54rwBWvR52Rj2F2A/HB
         C5u2sDzn7jaVTVnMNRjBZ+7hG17uayZrAB67zBG51EsvsQMxCO8B4SWUYX75A3ErGdhl
         SUNt9dn3gIptda1Rio2GZGqCoknK8KgWMlh92JbxsvQSn04Bk8InyWChYzJ0arAkFp77
         pyvacFjjo+h89x3hO60yyMqDrTlJU+WKx/5zBdjIkAURfIbItiOIXU3M917eOpQWNwW2
         zQrw==
X-Gm-Message-State: AOAM530yjTVkxwHdMKlNL3uG6+b3uumTdT06ZDDJvxpzNJ97f8RMpsbf
        4fcbbpMiGhsUQR8MW2s5IeckaL4j2Ah/LSY0/CkYm3HwbdTjMYqpZjog1t8yJFvKUoCuWXWKMKy
        U0KAv/FnxJfZh6BvvhN6Hz9se
X-Received: by 2002:a05:620a:269a:b0:680:a5c5:954e with SMTP id c26-20020a05620a269a00b00680a5c5954emr7178494qkp.468.1650300661653;
        Mon, 18 Apr 2022 09:51:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5s03dJEz37yFRd0bt8VJZXKfEi+tgI60K56wnTALH0l5S//HMzNqbEJEbGM7GALoZ4yLkjw==
X-Received: by 2002:a05:620a:269a:b0:680:a5c5:954e with SMTP id c26-20020a05620a269a00b00680a5c5954emr7178482qkp.468.1650300661440;
        Mon, 18 Apr 2022 09:51:01 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8670f000000b002e22d9c756dsm7277059qtp.30.2022.04.18.09.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:51:00 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Subject: [PATCH v2 06/25] x86/xen: Add ANNOTATE_ENDBR to startup_xen()
Date:   Mon, 18 Apr 2022 09:50:25 -0700
Message-Id: <a87bd48b06d11ec4b98122a429e71e489b4e48c3.1650300597.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650300597.git.jpoimboe@redhat.com>
References: <cover.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The startup_xen() kernel entry point is referenced by the ".note.Xen"
section, but is presumably not indirect-branched to.  Add ANNOTATE_ENDBR
to silence future objtool warnings.

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/xen/xen-head.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index ac17196e2518..3a2cd93bf059 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -45,6 +45,7 @@ SYM_CODE_END(hypercall_page)
 	__INIT
 SYM_CODE_START(startup_xen)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
 	cld
 
 	/* Clear .bss */
-- 
2.34.1

