Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C20F4733AE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241707AbhLMSLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbhLMSLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:11:40 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8ECC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:11:40 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so12166605wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eABLlwdhhQA4EtdJ9dTJbyW3eJdzwFqTfReCX7SfswY=;
        b=Q+uc31bNiJitSMqmr1/rJyPPWrnX2FrpDpzyQ3x2IUkYEYEWsPeoO7BauxVPvrSCpR
         I/rooyQX2u1yXB+q2X3HmZFopsNQPvwGGTtobKjUcI6GtxR0uGEGW35uHTQPb+MgQrRP
         St60ql6J9J7YkrUMVP8ph71/0klP4HxJMC5MGla5kQ4EfitKzSrBzekCUSZ8e86cMJFB
         PoiD0Gj0kWo5CJXDdr0nnuja2H1IT9+BxrxYFgxpuCAeje2GW7EwlMcqDTMdR5bXzFPi
         n0boV/hpPittJWGTzefXw68mnTEmbO+zeN7GFxKuiO+7juT3gm0/rl4glGuzVit0L2oE
         8nRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eABLlwdhhQA4EtdJ9dTJbyW3eJdzwFqTfReCX7SfswY=;
        b=VOi6jE3rF6aW5VVz4/J/BDUpINJnT+qWjtaeOZEmN9g0qOLBND7dSefHxGovxKiGru
         F8o05X5JtGWnP8IeLC7T70Mk2dIVONZky3F7IEMBEmKKbsjsaN9JH08IL4MOAKfPVXKv
         VohNphecyrwKloNBxV8YvlJyiXZjBOZZhiaePAH3scbcpwkB+v9VtQ/JKyXj1eWdjr+c
         +V0ECzb9iMoZGeY3XbraGn6TPq3z+b8Y6n4ov6h75kppylpb463bn8mROliyiDEoWTXE
         K3jhk9FYz6WeHQI0dZRK38ZnadyVVz9U/Q6mUde6sT/2oGFM/0Dxncly206r2aWk9Guy
         wNCw==
X-Gm-Message-State: AOAM531A90+btQ7E8wzXGvYRZ8My7cGTU0a5+5QWM9DaPOZEfKHXQiZ+
        vuibs8RHeW2qEMTMvDG8TPM=
X-Google-Smtp-Source: ABdhPJxrnILbtrKwTKTPwkYNsdvjUz2gzOftVzw5JaMQvHJtjxm1PFVZvA57d7rAiJv1hvhrm3YVcw==
X-Received: by 2002:a1c:f018:: with SMTP id a24mr289245wmb.51.1639419098682;
        Mon, 13 Dec 2021 10:11:38 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id t127sm8750956wma.9.2021.12.13.10.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 10:11:38 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     rodrigosiqueiramelo@gmail.com
Cc:     melissa.srw@gmail.com, hamohammed.sa@gmail.com, daniel@ffwll.ch,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 0/3] drm/vkms: add support for multiple overlay planes
Date:   Mon, 13 Dec 2021 19:11:28 +0100
Message-Id: <20211213181131.17223-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

First of all, let me quickly introduce myself. I'm José Expósito and
I'm a hobbyist open source developer.
My contributions are usually in the kernel input/HID subsystems and
in its userspace library (libinput) as well as other projects.

I'm trying to learn more about the GPU and I found VKMS as a good
project to get started.

So, now that you have been warned about my (lack) of experience in this
subsystem, let's get into the patches.

The series adds support for multiple overlay planes by adding a new
module parameter that allows to configure the number of overlay planes
to add.

I checked that the planes are properly created using drm_info[1] and
also executed the IGT test "kms_plane" to make sure that the planes
were listed in the output.
In addition, I checked the vkms_composer and -even though I'm not sure
how to properly test it- it looks like it is already prepared to
compose an arbitrary number of planes.
Having said that, I really hope I didn't make any obvious mistakes.

I noticed that the docs say:
> For all of these, we also want to review the igt test coverage and
> make sure all relevant igt testcases work on vkms

I ran some plane related tests, but some of them were already failing
without my code, so I'd appreciate some help with this bit.

Thank you very much in advance for your time. Any suggestions to
improve this patchset or about what to work on next are very welcome.

Jose

[1] https://github.com/ascent12/drm_info

José Expósito (3):
  drm/vkms: refactor overlay plane creation
  drm/vkms: add support for multiple overlay planes
  drm/vkms: drop "Multiple overlay planes" TODO

 Documentation/gpu/vkms.rst         |  2 --
 drivers/gpu/drm/vkms/vkms_drv.c    |  5 +++++
 drivers/gpu/drm/vkms/vkms_drv.h    |  1 +
 drivers/gpu/drm/vkms/vkms_output.c | 29 ++++++++++++++++++++++-------
 4 files changed, 28 insertions(+), 9 deletions(-)

-- 
2.25.1

