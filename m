Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9D8463AF4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243331AbhK3QIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237661AbhK3QIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:08:35 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A45C061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:05:14 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id a9so45548926wrr.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6PRs/V5Y6EZpCMvgrkcxuv2VbEomGkCv99QDJI2/D6Y=;
        b=QZvkppd9P5giq/9M1iqXis1VxuATz7zInnbzIpy/JjA3s1NNpbZhGgexmMgs+RmOsh
         9Cim6xRCCzyWB0QLuXrRX+i7UKoTZt5FWqtmTPxtYuxN0avB5IO1a59X+52HkU5iGNRJ
         Z0HSvR5oIjFRiZEESzLE5EGTRlWMfXc552WTpLNBXqXklvFUrmz66OVICvKp53VAYjPf
         JQ2cJdnxzT8x9fqD8yxwWGac6yY3/vzjfmTDvmoIMMTbuzeHmYQttVqyytSuo3a74k+/
         QYevSNWq509c6ndGIXGp5a4oZq08Plrqk55nR+3c4hEQ3A/QZgRbCtFmUIbwWAemWhpz
         ldqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6PRs/V5Y6EZpCMvgrkcxuv2VbEomGkCv99QDJI2/D6Y=;
        b=y4ohm++/Fix5AEq5Ul31GZ64w9eQVsX74gCrVhxdDsDyvwNoPajh+BuVu68fCmVg2Q
         ut+rNupV5ITUsDXE/azb+eFLCPiAH1QSRzYZ0wPXoaHLIaZeXiJ1idT9457+PVm+EJS8
         EQ/mWT3CtzVJBYh18IUGIlfQn6zytCHHiKbAKfFA+Ju1MydiRFiZVVdt1W8Bo16Z2viU
         Vkl79pNMYOKBbjKD3S6NrNXkyesVwbLngcyQscPXvgQFeycvgZBlgDWP28B71t2EMlEt
         FmkDxyqCz00BHnkYDGeSDE5yvIQG8vusFVcwlobTm8JxgmWnOF/l2be0SWbnKAX8Zwij
         G/DA==
X-Gm-Message-State: AOAM532+SyqOCieD80sLaLUYvYxBVOIZ0Wz3ILuA0NGE/QLmkNZdhrzc
        frFDUmkcCcvGqIctltQUmB4QBg==
X-Google-Smtp-Source: ABdhPJwMnk8pb7ycRX8NcND9sOZ1Q7oJAh+z9HlheUzdx6PaqI2H9zSzan6Eor/lSXf3ayYReeh4Gg==
X-Received: by 2002:a5d:62c5:: with SMTP id o5mr41555909wrv.408.1638288313240;
        Tue, 30 Nov 2021 08:05:13 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id g18sm16719409wrv.42.2021.11.30.08.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 08:05:12 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4] ASoC: codecs: Qualcomm codecs fix kcontrol put return values
Date:   Tue, 30 Nov 2021 16:05:03 +0000
Message-Id: <20211130160507.22180-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,
Some recent testing found few issues with wcd934x and wsa881x codec drivers that
are not handling kcontrol put correctly. This patchset fixes those instances.
Along with this there is also a bug fix for the way channel list was updated for
wcd934x dais.

--srini


Srinivas Kandagatla (4):
  ASoC: codecs: wcd934x: handle channel mappping list correctly
  ASoC: codecs: wcd934x: remove redundant ret variable
  ASoC: codecs: wcd934x: return correct value from mixer put
  ASoC: codecs: wsa881x: fix return values from kcontrol put

 sound/soc/codecs/wcd934x.c | 132 ++++++++++++++++++++++++++-----------
 sound/soc/codecs/wsa881x.c |  16 +++--
 2 files changed, 107 insertions(+), 41 deletions(-)

-- 
2.21.0

