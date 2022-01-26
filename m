Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB54C49C8BB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240779AbiAZLgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbiAZLgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:36:00 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2B6C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:36:00 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id c23so9565388wrb.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tVkN4OAkdGyisUZxAmo/IqALBwMBj8OyZCisknx7/mA=;
        b=O6bf86A7Qxq2G/W/kK3ZYJqVRRc0uhzCfPARgrYMgZlXEiF5R65napOfGjyLjpT2Iq
         NSkXEMz1QLMIJuBLpECqGhF7dzqlUGB8SQTcqnvj9ogdfcZV7W2049/q8uAWtCIY/Yta
         aoi6PyBxkzLvDAkSB6O30w3LKktlpmZ3HEyrCUi6IrIG/t4pm/d6UzfAonz7C8Y/kQDP
         yXkiaoLb3UHwyEeEHK3UVkmqgLyanb1nVrKMyAXB9doRyHElr9YM0KW7zzF0SqMa0tmq
         cyTIaAUkWvMlzR3xnSmblf7OzjMOa/qhKNI5Fx13aCzJmaD7eqJgE5XNcffQkzFc4jPw
         ofEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tVkN4OAkdGyisUZxAmo/IqALBwMBj8OyZCisknx7/mA=;
        b=k/Yq7PixQ42BRBgDGbw3HDCDwWqUOlZUoAUNlsWLhvwRDPWfTWRxUXnzqVFv/zTQ94
         M/ghgIxrKuet4xCxs/vTeYaqoe5povW69kYQ02W/mqvP4PrCWZ7GzG8Fp0zLNto0/6Fx
         6Qp0goSh/yrlagnJ6pblF+U1AIILebjwoI3+nVVUACFUCyXHFByIuiIh4XUba28U2rXB
         yvVR0GOxq0lTNCt2iLvfAYgXe8vhoZ2keNzXuvL5GUBVqYW5ASCUkBFEG4XzVwDoJBWt
         Law5roI7PhPeLSvm+8mPRMwCUmM1ICQaDuiOREwB1J2NsgQCMkWoNjjTynKC6U0x/mBz
         32BQ==
X-Gm-Message-State: AOAM530j0cxzYVE9qKp97Jc2Rncd72lC0/jB/mbT+m5Rt+604QH64Yk7
        u9Q1Y4rsVNsRqoPthRI2SOOE4A==
X-Google-Smtp-Source: ABdhPJzgVBb4sDJ5KH3MciI/B5HZ8ZFYuQMgYxUIUMgbYZfGiijc7QVWVuf5VfWkQtp1aRnD2CEbDw==
X-Received: by 2002:adf:d1ed:: with SMTP id g13mr7249298wrd.682.1643196958858;
        Wed, 26 Jan 2022 03:35:58 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id n14sm11999188wri.75.2022.01.26.03.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 03:35:58 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4] ASoC: qcom: fixes for Qualcomm codecs and q6apm
Date:   Wed, 26 Jan 2022 11:35:45 +0000
Message-Id: <20220126113549.8853-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Some recent testing found few issues with wcd938x and lpass-tx codec drivers.
WCD938x was accessing array out of boundaries resulting in corruption and
system crashes along with not handling kcontrol put return values correctly
and rx-macro had incorrect sidetone registers offsets. One final fix in q6apm
to add a check if graph started before stopping it.


Thanks,
srini

Srinivas Kandagatla (4):
  ASoC: codecs: wcd938x: fix incorrect used of portid
  ASoC: codecs: lpass-rx-macro: fix sidetone register offsets
  ASoC: codecs: wcd938x: fix return value of mixer put function
  ASoC: qdsp6: q6apm-dai: only stop graphs that are started

 sound/soc/codecs/lpass-rx-macro.c |  8 ++++----
 sound/soc/codecs/wcd938x.c        | 31 +++++++++++++++++--------------
 sound/soc/qcom/qdsp6/q6apm-dai.c  |  7 +++++--
 3 files changed, 26 insertions(+), 20 deletions(-)

-- 
2.21.0

