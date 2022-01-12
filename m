Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A7048C762
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354679AbiALPkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiALPkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:40:19 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB627C06173F;
        Wed, 12 Jan 2022 07:40:18 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id d3so9403987lfv.13;
        Wed, 12 Jan 2022 07:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7YzcHELoQHE6lsWBBlYzNlfti5+qLJvr6LQTidmKO20=;
        b=A/K8h4Hb+/kmC14dRYp4GUa5XZrjznZgoK+QJ0/eZYRVzxAZ4YrO7RFViyjOu6tYa+
         NL224hlp/f2CwFEh49nizaxrbPFUPvL6ClidPqYzGLm8J4qOH1PQM6Y2GdGkGZ6R7fzE
         Vxl0Fk2Oz57Pn0WIpYO6iPijYsDktxfEAmNDuEZG02KBB2wv7OJtUaYAx8GJmCgYzYcf
         jsgcLDI+eQwa2CSwDxUl+ccEJVip92Y38PgBpbBYBbxmax7S/2KR6fc16FxhSvXfGEWw
         8kIPbJX1dkqLt2+yN6iG5ABRZCt3fP/CXHpwes6uHzSt87l2zHz4WRO7tG9oYE5SxLua
         i9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7YzcHELoQHE6lsWBBlYzNlfti5+qLJvr6LQTidmKO20=;
        b=vlQGPJC/qb1of1wqJWy3P+2Z0t8MBzgZQZmhoa2lEEv4c6fmAJkDarPYByAh0gqCAY
         sc4CgobUGlR9HvOaijRY31vAyElivh5d1OjvrJwD850cVE/4XXegoigzUK8Zo3kYHfsN
         lx4nCDYbzWOaDzfp6bTT1yMTGF3+KmEdjcQH/I5usPHb76sQIDOaMrmUk8aPwyTBk03i
         92y/HIhXBIBSVAjA7ybn66EM9uKDeIVuEhG95JZ8T+T2cZzMM8qPHnX3n0nAcd3sOmVl
         gbTepmCKMUg30HHrYV5eyY5gaS+iTchdyh5PNdIbfMSo5SRxUnEiqxjOCnur/4ynmFlR
         NaXQ==
X-Gm-Message-State: AOAM532MEUCXHb7A/1qU47k9/2CnV8mvWZa7+NuqkTE+krJkge1e7/OH
        RVrLnCtbsS4TQ/Gx/B/KlhM=
X-Google-Smtp-Source: ABdhPJwOEEebyuP7EAEmCPtKjHEQiyeb0fgrZNYFW9s4PnlrOT82YWv562fvSljJ0XzY3hXketcblw==
X-Received: by 2002:a2e:8695:: with SMTP id l21mr76627lji.452.1642002017185;
        Wed, 12 Jan 2022 07:40:17 -0800 (PST)
Received: from localhost.localdomain (94-29-62-108.dynamic.spd-mgts.ru. [94.29.62.108])
        by smtp.gmail.com with ESMTPSA id f27sm20173lfk.266.2022.01.12.07.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 07:40:16 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Add V4L stateless video decoder API support to NVIDIA Tegra driver
Date:   Wed, 12 Jan 2022 18:39:50 +0300
Message-Id: <20220112153952.1291-1-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support V4L stateless video decoder API by NVIDIA Tegra decoder driver.
Tested using GStreamer [1] and libvdpau-tegra [2].

[1] https://github.com/grate-driver/gstreamer/commit/b8509bdbb69b534e61419ea1798f32f9ad2f3597
[2] https://github.com/grate-driver/libvdpau-tegra/commit/f822e95911e5e0c39f8ba19f843ddc1e0138d5ce

Dmitry Osipenko (2):
  media: staging: tegra-vde: Factor out H.264 code
  media: staging: tegra-vde: Support V4L stateless video decoder API

 drivers/staging/media/tegra-vde/Kconfig       |    7 +
 drivers/staging/media/tegra-vde/Makefile      |    2 +-
 drivers/staging/media/tegra-vde/h264.c        |  988 ++++++++++++++++
 drivers/staging/media/tegra-vde/h264_reader.c |  264 +++++
 drivers/staging/media/tegra-vde/v4l2.c        | 1013 +++++++++++++++++
 drivers/staging/media/tegra-vde/vde.c         |  700 ++----------
 drivers/staging/media/tegra-vde/vde.h         |  129 +++
 7 files changed, 2487 insertions(+), 616 deletions(-)
 create mode 100644 drivers/staging/media/tegra-vde/h264.c
 create mode 100644 drivers/staging/media/tegra-vde/h264_reader.c
 create mode 100644 drivers/staging/media/tegra-vde/v4l2.c

-- 
2.33.1

