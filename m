Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBA953CE2C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344546AbiFCRhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238776AbiFCRhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:37:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49E9639BA7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 10:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654277863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4wY2ti1jWVmcco4dB7M/EO1qrDihEXd7FNjPS1P93a0=;
        b=aX4OJpM0z2y4jajZiiBbQ9F8rDffY81PeDPouO8FUQTisx9NudFRJ+ipzA96nMJkwy4zcP
        uci0GqVEyj2iY1W/xJvH9LYloxwcdtH4kK1ZWgh2EEtfJrLu+4JEHGBAPvCP8uJfLnZzPd
        RnG44/3HCrYTfe3k8rXT0fM5foAV8Mw=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-U-ithwNHPauNhYg2hNOIuA-1; Fri, 03 Jun 2022 13:37:40 -0400
X-MC-Unique: U-ithwNHPauNhYg2hNOIuA-1
Received: by mail-il1-f200.google.com with SMTP id i16-20020a056e021d1000b002d3bbe39232so6664806ila.20
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 10:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4wY2ti1jWVmcco4dB7M/EO1qrDihEXd7FNjPS1P93a0=;
        b=wBfZ4wSHUC0WlLfBUqZbr+nW9gPsz5Nb8W7iHPXUVKZgiGy6rwP/JKa8pDYYIhVaGe
         R8MZxz8gal3AC7dxXF9GUb4JrUwJbeC4T1SQyJoVDYLPVpZMltZ5ALsm5XC+DUBabLYv
         I/1UKN2nT9dAp+y0q5LeZIcyIBbcX5+IgrHcpGDPvYvS3keuFdF0ZJ02vukzpn5vXHTz
         3+RQ1A90YLc3wupFC+8mMFVwj278+rlpyneZux980keXPtmM+qgQ+eJJUFXnwidrG49Z
         YgYL3BZb/S4uxF2TeRONchWRGugkjbowuT7Ep80g6hEmkSxQbECInn1C21oFwnBfLl0D
         9f3w==
X-Gm-Message-State: AOAM531j3DIKSrv/Cp24RjVj8MJ2cEJO0PUHN58ucb+XDkb9yd5UQZah
        UM0ak9F3C+t2nPK7CxlYQMKexj6tFQv56XiJ8EC2zDZ5nDv0UWjrwDhzsb/S52BRUIwClaLDrhW
        G81OifRWR6houVKaG5G7qSUdCERaZiCWG16ThokIuulwweT9yasYFZDVtgWe1+dIW9L+nIEM4WA
        ==
X-Received: by 2002:a05:6e02:1aa6:b0:2d1:b452:f143 with SMTP id l6-20020a056e021aa600b002d1b452f143mr6717758ilv.278.1654277859470;
        Fri, 03 Jun 2022 10:37:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXXN7nQhcHYuKYC3FMdwo6WzrsYqUkRVcgdkpnlgAN7OoTQ+TqlM8ndxiikifU+UVw8ICjBA==
X-Received: by 2002:a05:6e02:1aa6:b0:2d1:b452:f143 with SMTP id l6-20020a056e021aa600b002d1b452f143mr6717740ilv.278.1654277859142;
        Fri, 03 Jun 2022 10:37:39 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id g23-20020a02bb97000000b0032e1e0ac289sm2791117jan.8.2022.06.03.10.37.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 03 Jun 2022 10:37:38 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com
Subject: [PATCH v2 0/2] userfaultfd.2: Update to latest
Date:   Fri,  3 Jun 2022 13:37:34 -0400
Message-Id: <20220603173736.62581-1-peterx@redhat.com>
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

v2:
- Use semantic newlines always in patch 1 [Alex]
- Fix s/.BR/.B/ in patch 2 [Alex]
- Rebased to http://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git

Add the two missing pieces till latest 5.19-rc1: the UFFD_USER_MODE_ONLY
flag, and also the recent wr-protect support on shmem and hugetlbfs.

Please review, thanks.

Peter Xu (2):
  userfaultfd.2: Add section for UFFD_USER_MODE_ONLY
  userfaultfd.2: Update on write-protection support

 man2/userfaultfd.2 | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

-- 
2.32.0

