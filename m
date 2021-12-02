Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1C1465D7D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 05:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355553AbhLBEqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 23:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355539AbhLBEqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 23:46:01 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF7CC061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 20:42:39 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id n8so19361667plf.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 20:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q/XmdYzmWlBC/voF+84Cd3udQjdonRFCNCIqCUmDhDk=;
        b=NNI4lbBLOzUh6enNA2zXDD6i/1bbGmC+FP6nollo+ZHi511xLiHCuXuklfoEatdbSW
         c/K2UDB3imN6OpU5wZVX9y/cgHytjg748J8xZWdpWc5c2s/mjPDhWwgVMqKKaZGX/KR8
         N5KEWOuSX6ObkcWzGMI0QUSJfrREjzwt0FlH38L7xhCnOUlCDKqwF76FdcUJMuPKFyyf
         NcPOfpJLQ3fdoJX6usozrWel3ddfQu+4oIgNFru6sBQG3JAIVq+ToAIk0jcJUNombClm
         98B1D6VwKpA9QpeCwgFuO6oyX8A9MSk+vYb9i38GLAnPQQTpxaDTVACDW5OSlJ7IfZLR
         NVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q/XmdYzmWlBC/voF+84Cd3udQjdonRFCNCIqCUmDhDk=;
        b=FCzCY0fy9WD4UoT3rPilH40w7N4Nb5dxxRixy2DNBrsJaVda4PCUOcXu1twLu1qzue
         +hhIz70Mvnlf9McU4nyLLwAVbDV9NDu7CZ0YKp4MKNY4R+DkyZeBJQsGfj5AH/T+WNTg
         0NZ4nEha7G7Kwg+aHAQMx09MwEJidUyTCtgHaDoRhZOIVAqow2q0xQ6giMkxhh3hq7Bu
         j58zoniY0LDx9CbvKMvSFmxGlLvKWzgb91r378G/4vomOL2g5qOaigAIhL+3ob9CNtD8
         be2zwnTb/+SVxu/NoJysaKJX439u3d6Lz0ycqH2BAv6p48ZAVpcJ7vf0hyBcCBlSk+7h
         TSIQ==
X-Gm-Message-State: AOAM5312Bf3bJajNFkDqDvHouD+x7MAtPCRdnpQgkvb6TiYSgfrH498K
        h8yF5dL0MZe45v6pXS9RlG3NGg==
X-Google-Smtp-Source: ABdhPJwd7LFTasLsCKCBBJSOBzXW1hcUhBvCVvh8QO8kQ/q9LWJdPJFWFfi3xByxw9fLIekXcskJdw==
X-Received: by 2002:a17:903:1208:b0:143:e4e9:4ce3 with SMTP id l8-20020a170903120800b00143e4e94ce3mr12739440plh.21.1638420159291;
        Wed, 01 Dec 2021 20:42:39 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:ce4d:ddd8:41f4:d987])
        by smtp.gmail.com with ESMTPSA id p19sm1545646pfo.92.2021.12.01.20.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 20:42:39 -0800 (PST)
Date:   Thu, 2 Dec 2021 12:42:34 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        cujomalainey@google.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        sound-open-firmware@alsa-project.org
Subject: Re: [PATCH v9 2/3] firmware: mediatek: add adsp ipc protocol
 interface
Message-ID: <YahOuiIZ/wGR/TpD@google.com>
References: <20211201075604.27864-1-allen-kh.cheng@mediatek.com>
 <20211201075604.27864-3-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201075604.27864-3-allen-kh.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 03:56:03PM +0800, allen-kh.cheng wrote:
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
