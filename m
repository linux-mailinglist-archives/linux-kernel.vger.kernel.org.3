Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BDE5800A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbiGYOVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 10:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbiGYOU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:20:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F80213E17
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658758857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1IdJxIm7Pi/v88hck1ZpRxA4gEl56WC6ZAkG/ZDca0Q=;
        b=DOncig6BiXjIZ6xFa9J+cpTHRVEbEIwtfQYNG9/2XkL+zxBe4i5dNiKJfISh+scsv0uS+r
        +YhGvQRgfADW6ru9a+1jhPIphbxlRdqR21+HAYIYyYVtdygKJhgnOt9mSiGvlGKTw9FTDU
        n3f4600n8BcECfYKXLCsDlBtIKL8C6I=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-2Zwo5GDYPpWMiNw-mJv-9A-1; Mon, 25 Jul 2022 10:20:55 -0400
X-MC-Unique: 2Zwo5GDYPpWMiNw-mJv-9A-1
Received: by mail-qv1-f70.google.com with SMTP id eq6-20020ad45966000000b0047405c4e6ffso7661178qvb.17
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1IdJxIm7Pi/v88hck1ZpRxA4gEl56WC6ZAkG/ZDca0Q=;
        b=B9D0TgmhhgmTtgea6kHufFQAZB4dHDo4ERVt8M5oB0IFaGuWeykT7KQPQ7Pm2FgkQi
         w0/IyI/6st9s371b5RFrqEIejpkcPD00XaRWr9gh0zzx8331N/gwa8/cIXnSeo04kgOR
         P+x3ieWTAIeOu/8Ey0rl8JXtHCbQYuf04XlmSf5aAzfSZGd/6lUia/VoBIEHnHrn0nKz
         YVMcFCBwCEhP9aX5te2jx7MQ55HEa2KeXdSpK7266L94mIh3HYbhp187uG+OLGjWv26D
         sLdcjnbiHjpWpZtbtNZyNXeqfpFsnHuWIKxMCi4CeRMFeD9NGnc7p8AOLjsPNWPtvDyU
         XLOw==
X-Gm-Message-State: AJIora/5j+hkW4+lhPZiKLY9CKHgMe93tJSduOiXMZaSHKgL/Q032vrU
        3ksVoizmU+XCnDyC90Se4OuTfohjMGIzBhUki11YS0b+nAdI7hoGhY5JpCDiL86k+AJvPiva+zz
        USGUkGWAsUhW10pwK1IJ+vFpVXrwNz05xyZ8JLQLbIIKjh7WinNhtI0hdtX8KGojlOcPkSJ75oA
        ==
X-Received: by 2002:a05:620a:4501:b0:6b5:fc79:32c with SMTP id t1-20020a05620a450100b006b5fc79032cmr9486506qkp.726.1658758855156;
        Mon, 25 Jul 2022 07:20:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tuoYzI2hhOmTZFo0v8ReCc+YKwDV9FF0YFKaTwoaD98hZidKb99/Jpmlo439ptHjPPoX+xIg==
X-Received: by 2002:a05:620a:4501:b0:6b5:fc79:32c with SMTP id t1-20020a05620a450100b006b5fc79032cmr9486475qkp.726.1658758854855;
        Mon, 25 Jul 2022 07:20:54 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id ey14-20020a05622a4c0e00b0031f0ab4eceasm7626071qtb.7.2022.07.25.07.20.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Jul 2022 07:20:54 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 3/3] selftests: Add soft-dirty into run_vmtests.sh
Date:   Mon, 25 Jul 2022 10:20:48 -0400
Message-Id: <20220725142048.30450-4-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220725142048.30450-1-peterx@redhat.com>
References: <20220725142048.30450-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/run_vmtests.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index 2af563a9652e..de86983b8a0f 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -190,4 +190,6 @@ then
 	run_test ./protection_keys_64
 fi
 
+run_test ./soft-dirty
+
 exit $exitcode
-- 
2.32.0

