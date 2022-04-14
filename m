Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509955017FB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350736AbiDNP64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358349AbiDNPlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:41:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3C2CECC67
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649949834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dJ952WGOXndZeyhd9vxjBUmOeHfnPduqI8EF8AuKcTY=;
        b=N9kkUclSHO5/n4gZDQPB1pSmldgMEcNIojEvwNNOmRcY6hvQy4uE6ihjEkeqt4ZwCL4tHt
        iXfPMvkAdAy3GSaGVbxN+5tNDixgRzrUtGq1ynF76byB6/34YlWSF4RDA0vHyt1gBM+x+8
        0EEY/s4y0aKm6XgOExMSXyk2tC1r6JI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-Ddo7WSbdPSGH7jaIc3I0XA-1; Thu, 14 Apr 2022 11:23:53 -0400
X-MC-Unique: Ddo7WSbdPSGH7jaIc3I0XA-1
Received: by mail-qv1-f70.google.com with SMTP id jr12-20020a0562142a8c00b0044429017bcbso4598789qvb.20
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dJ952WGOXndZeyhd9vxjBUmOeHfnPduqI8EF8AuKcTY=;
        b=lrb6NWN9ICq5GO/ue27ZtMj05Ic0yqpEORt1yQamFHSuyqKSnvMeuJ9w9JECTH6LiZ
         6gkWuyaga7Agwb3t6AnvWpz6oWPFHToaoEENW9DiuoeZYki3D7ZMcugg5WzbF166x5M+
         +ahADfjTifr5ZULpZmrYnSq+Qag6w+zi6rJ4ir3/kGznooYgveHTmYG5kUDP4g6VWWp4
         X4wLoCHPMCpJCEBud3xdr4oNpEV6AZvgtMuKhCnHruEHhBxZhL3FFMd754mrOUVJabDL
         Ii4uFOTcbtk52r1vUefMml17ZXmSojoJMom6mRF4l+Eu4+tYBnYaRBRdMMHqptPQDp0t
         5BAA==
X-Gm-Message-State: AOAM531gYQqA/0rVPkR6v3cNPrJFo/Q1e8dvlvIZgBmGp2qkEBxu5Bvh
        oi+9TYXPzSMv71NnCeE5q+51nve7jXTZDgCnliBjclxnym05tBjv4Sf+Tj3KIYDXdqeRyJc+o5M
        7FfZenBqeq3pPCimFRRFp56sO
X-Received: by 2002:a0c:b2d7:0:b0:443:afac:fc60 with SMTP id d23-20020a0cb2d7000000b00443afacfc60mr3750474qvf.58.1649949833141;
        Thu, 14 Apr 2022 08:23:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDfFqGhctIMuMkohOJTACk8HeRnuayiX/2TbehKgCD7SAbsugdHp+eT2bykwpixK0AJIEDHg==
X-Received: by 2002:a0c:b2d7:0:b0:443:afac:fc60 with SMTP id d23-20020a0cb2d7000000b00443afacfc60mr3750456qvf.58.1649949832926;
        Thu, 14 Apr 2022 08:23:52 -0700 (PDT)
Received: from fedora.redhat.com (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id p5-20020a378d05000000b0069beaffd5b3sm1166038qkd.4.2022.04.14.08.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 08:23:52 -0700 (PDT)
From:   Adrien Thierry <athierry@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <mripard@kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Cc:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Adrien Thierry <athierry@redhat.com>
Subject: [PATCH 0/2] staging: bcm2835-audio: minor code style cleanups
Date:   Thu, 14 Apr 2022 11:23:38 -0400
Message-Id: <20220414152340.68932-1-athierry@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

This series contains minor code style cleanups to fix checkpatch warnings.

This handles TODO item "Fix the remaining checkpatch.pl errors and
warnings"

Adrien Thierry (2):
  staging: bcm2835-audio: fully describe config symbol
  staging: bcm2835-audio: clean code style warnings

 drivers/staging/vc04_services/bcm2835-audio/Kconfig         | 5 ++++-
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c   | 5 ++---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c | 2 +-
 drivers/staging/vc04_services/bcm2835-audio/bcm2835.h       | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)


base-commit: 194193dd06848c1839d928090cb2032eec8b2f9c
-- 
2.35.1

