Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF8D538976
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 03:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243292AbiEaBMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 21:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243067AbiEaBMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 21:12:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EFDB9398F
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 18:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653959525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=uY3Q5t/YVyCbs5m+kSxWQrSqX2D5qqz1qZgdmSgdE/A=;
        b=HEOGQb41vnLW3inRrTzSRlDRQWR94hDM6HPLkHvzW1Sl9bWzyMGMnWOKSEq7a36jLzDGcv
        PboqgKUck0qAD6aw+uHR6be6nJ8qXpgMkapKDrZ+v6I028hbfITr5yGfmJwMKDH5evyVkw
        h3TNS4RAreqqmEJwsMTr6tWZNsmLbms=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-l429GQzqNSOWGh78bxiLgQ-1; Mon, 30 May 2022 21:12:01 -0400
X-MC-Unique: l429GQzqNSOWGh78bxiLgQ-1
Received: by mail-il1-f197.google.com with SMTP id l8-20020a056e021aa800b002cf778c63caso9246743ilv.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 18:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uY3Q5t/YVyCbs5m+kSxWQrSqX2D5qqz1qZgdmSgdE/A=;
        b=YfDWiVV0aTA+i9f4NBZrrPp1nyYZayVakY3EdgIoKooj1XyftHFgZ/PA17aq3Bq5tn
         LPa+OExEnOQXa+QJdfcbBOwNSJi2awmiBfUveUPZCfxXHTubKWEpr3qPIxhpP+f7OJSv
         5D7FXM0zWHzqDWP4OcapZxppOd+anCVdhyr9ToUyi8qys5cbj75nqjc7WzuBAJd3dKfU
         O4DGV9jTu/yVV0H4gcT82W42BwBDPivFJk624VWwJm2eOK3BRh/GlvSv3PSZBjpZsF9Y
         wFSxQa12x9V9JRELXUXhys13XEFLrN7hVIWoxwfYgW339BIc9Z3+Pv341JFHxDKTFCB+
         aLmA==
X-Gm-Message-State: AOAM533ezmnzfwh4AiXCbrTw9aoHlk8pz7brOT0/1EBitsh7ttqY5HXt
        4+NpRJVaiImUnGiXK2khJh996SLEdqMlL6Zpy7h4anDnq/bfiJUFXt+Xicpgqp6cqwgItwOcRrp
        EXzB0oWc3Svba1YOk2N/XiSbvE+9CAS+2SNZWDo8nWXVcifVmBgWnNIPhv4w+TWpqbv7MyaR8JQ
        ==
X-Received: by 2002:a92:ca45:0:b0:2d1:b7cf:26a9 with SMTP id q5-20020a92ca45000000b002d1b7cf26a9mr19174949ilo.52.1653959520565;
        Mon, 30 May 2022 18:12:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeURDuT17RoMdt/uGX/WT1sdcY73aFHJEA9T6tFDlMEsYyTOLLFA+3AE/oWzP7hkMJWJHdWg==
X-Received: by 2002:a92:ca45:0:b0:2d1:b7cf:26a9 with SMTP id q5-20020a92ca45000000b002d1b7cf26a9mr19174930ilo.52.1653959520215;
        Mon, 30 May 2022 18:12:00 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id s6-20020a02c7c6000000b0032be3784b9bsm3158234jao.117.2022.05.30.18.11.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 30 May 2022 18:11:59 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] userfaultfd.2: Update to latest
Date:   Mon, 30 May 2022 21:11:55 -0400
Message-Id: <20220531011157.46868-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the two missing pieces till latest 5.19-rc1: the UFFD_USER_MODE_ONLY
flag, and also the recent wr-protect support on shmem and hugetlbfs.

Please review, thanks.

Peter Xu (2):
  userfaultfd.2: Add section for UFFD_USER_MODE_ONLY
  userfaultfd.2: Update on write-protection support

 man2/userfaultfd.2 | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

-- 
2.32.0

