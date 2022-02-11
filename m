Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B844B205D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348098AbiBKImq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:42:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348100AbiBKImp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:42:45 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244E1E5A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:42:43 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id om7so7463498pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CGAayov/+ln4jw241yuyUW4Ct9nFUZ87co88ghlbBxs=;
        b=JBTQjbSXF3YPniG9xLJNKSrGKXFx1bLPF+uqoUTCBbIf01mDmIvu56ZNTesVGlXjcZ
         o1yVHu32Fa5TOQjqIIKEE6qRYIn9uy9FgF+Hkm1uSdbubJtor7F12mVSIU9IDX57Scgy
         xmGHxw7Dm+YRWla98b2TSZJ9GDCnajM7eXlzn+Sfe1sYow7OEOTT2IyfFgm4C86AsK74
         QHN+zQBUQqcfwtTQBviyN3+UNhBPe9N610Y7CeMlICwpHzcOPGZCCNs9WePO1D5pVzU+
         BThx9BjjfzYmGvpEOnhBYE5PG+HoXwPkigro/bJAfj3E4ioSEgWZOw5gbblsopqgnSm7
         Y/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CGAayov/+ln4jw241yuyUW4Ct9nFUZ87co88ghlbBxs=;
        b=PBsZd85nQcK9UG1kwDOUDo2wEDzBpRn0+eqEjyPdsEk9+XteX3SArpSTtpOwdMrTQ5
         aMu+KmgwC87GDs+Imjs6BsMQ4DJRO2TqZSihQiaSkkneELV9DXcr0B6IGbO2HIbQUyID
         HcUM6kjsPL6pDqvcUQ4U4UW18pCp6weuJGHpyPZhEn4vlnXtjfmyQXYe/RBlEZC1EfTz
         hoF7kwDvgmlb9Pu95JksLLA77FrVd3oD2p08bZFaN0GIh1GfZQOzL1UQ7PXRJ09pT9Rn
         ILz87ZFVLSpwaQRMFemYDCgna+AEDWF7FunE6dPBi1jrmrQOBmUCYQHIcaItYCcNDEKs
         EjDg==
X-Gm-Message-State: AOAM531lRtfj+3gOh62xzqKvx5N7W+4EMlv+5G7EhuR5qRxmWw+OAaJ0
        Weeq6J1lGRgDmsHNJObUrB3T4eUlh2QjQg==
X-Google-Smtp-Source: ABdhPJytPoIyffxZ0megHXcbWD5+PkOjOTyQ9qJOzHAP2lML9ZVoHZrvfB46L3enU00p8a1n8YykHQ==
X-Received: by 2002:a17:90b:3e8e:: with SMTP id rj14mr673323pjb.38.1644568962619;
        Fri, 11 Feb 2022 00:42:42 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.72])
        by smtp.gmail.com with ESMTPSA id p21sm13368481pfo.97.2022.02.11.00.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 00:42:41 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arei.gonglei@huawei.com, mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        helei.sig11@bytedance.com, herbert@gondor.apana.org.au,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 1/3] virtio_crypto: Introduce VIRTIO_CRYPTO_NOSPC
Date:   Fri, 11 Feb 2022 16:41:06 +0800
Message-Id: <20220211084108.1254218-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211084108.1254218-1-pizhenwei@bytedance.com>
References: <20220211084108.1254218-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Base on the lastest virtio crypto spec, define VIRTIO_CRYPTO_NOSPC.

Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/uapi/linux/virtio_crypto.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_crypto.h b/include/uapi/linux/virtio_crypto.h
index a03932f10565..1166a49084b0 100644
--- a/include/uapi/linux/virtio_crypto.h
+++ b/include/uapi/linux/virtio_crypto.h
@@ -408,6 +408,7 @@ struct virtio_crypto_op_data_req {
 #define VIRTIO_CRYPTO_BADMSG    2
 #define VIRTIO_CRYPTO_NOTSUPP   3
 #define VIRTIO_CRYPTO_INVSESS   4 /* Invalid session id */
+#define VIRTIO_CRYPTO_NOSPC     5 /* no free session ID */
 
 /* The accelerator hardware is ready */
 #define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
-- 
2.20.1

