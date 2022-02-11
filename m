Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1304B2E1D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353082AbiBKUBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:01:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241940AbiBKUBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:01:31 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77199C50;
        Fri, 11 Feb 2022 12:01:29 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id l19so12306923pfu.2;
        Fri, 11 Feb 2022 12:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=djUqKgEMr5JnDB3khPKXvyCPVs5A4oczwMNvYBRAPN8=;
        b=oQJox6Mn50uPaz3pjhbCzhpaZz7t6r9bpyk0eVBdR0Rn0vSg6Iw4hayvhF4xNWoPV2
         YYrwfb0Whm29gSpQmr+BwRIMNQW3ZX8xQ48bzY7Fs+PecOdO7Hu65LDkd1tqce5M64Jv
         BU/lmcqF2YoExs4ZfD8MhBiUf/EM3/z/grWJn9dDp8LKydv88RtRvRaMSYTXCr6kOzZP
         MoWv4pV5t10M0uz6qMGTebiVBRLgA0m2BjzhLeEkQ4lWADvlPlV+Vess0Z71Sf1mZGDI
         1FyAsdTGKQ2XaXFjtdVRTUCg6NJqTFAMezD0UpW+dtFgyt1WWCLvVRkPwe4gqdhLxqgV
         cgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=djUqKgEMr5JnDB3khPKXvyCPVs5A4oczwMNvYBRAPN8=;
        b=i9oLWUDE/4wTwziu3STkA2skRfdMx5bxN1MCycIYfTga3HfjjbsPc8Kz32VGVHujsc
         XvivThdDztH0i/n2GmGRLvU70Ul0bR0nQI3KlJZUtGZa76f+St0ciYuaU4fyhA9MhlWU
         Tff9g6LfTdOMVf94Qx/XW2CvImzWOIBWrDpXWCe4QXISVbSCCWVVD7nJlU29GnkOVCpS
         CxX3MfISd5ydx/XGZRa5VJ/ncb7b8NUP/xcJmPMMbhf/CxlMPqlqkLI4vItpF0PMFO3s
         gq4+HMu5eF2qWLepndw9k4Iy0Y2O57LcfoBkdY03C4bhlezpcgTZ1XxUsywPYPOJzBJ6
         IkhQ==
X-Gm-Message-State: AOAM5330RmMKatSbyyXwP8fG0xGhX1VQjME/P0SbC4Vw/aO1CPGBmZTC
        MtXjcuSmANhMinv/3dmXQTatVDe+FWUy2uNpd2g=
X-Google-Smtp-Source: ABdhPJz8KcZnsOfWVg1xgEf6Tb4ds0aTMpU+zsXROCZbleto1V69nnSqSD8ruUBunjYvMdvjPNaOKg==
X-Received: by 2002:a63:36c8:: with SMTP id d191mr2651287pga.377.1644609688877;
        Fri, 11 Feb 2022 12:01:28 -0800 (PST)
Received: from localhost.localdomain ([117.194.161.23])
        by smtp.gmail.com with ESMTPSA id f15sm28915080pfv.189.2022.02.11.12.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:01:28 -0800 (PST)
From:   Abhijeet V <abhijeetviswa@gmail.com>
To:     Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] asus-wmi: Keyboard rgb led multicolor support
Date:   Sat, 12 Feb 2022 01:31:20 +0530
Message-Id: <20220211200122.9821-1-abhijeetviswa@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This patch series adds support for rgb keyboards on certain ASUS laptops
by utilizing the multicolor led device class. Much of the wmi
interacting code was obtained from the faustus kernel module:
https://github.com/hackbnw/faustus

The driver is hardcoded to use only the static mode provided by the
platform. There are other modes that are supported like strobe, and
rainbow and also variable speeds. However, I'm not sure how to integrate
that into the led classdev. Support for them could be added in a
separate patch later.

This is my first contribution (other than reporting a regression to
asus-wmi recently). I've tried my best to stick to the kernel's code
standards. I apologize if I've missed any obviously glaring issues.

Thanks
Abhijeet


