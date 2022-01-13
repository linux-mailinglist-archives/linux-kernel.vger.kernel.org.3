Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803EA48D11E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 04:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiAMDwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 22:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiAMDwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 22:52:42 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C924EC06173F;
        Wed, 12 Jan 2022 19:52:42 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id l15so7633943pls.7;
        Wed, 12 Jan 2022 19:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=r9QyflpgjEtFsGD0y6UQIHwiwSsCeZuAWvAVlYRq76A=;
        b=o2TD16brmx4S02l2pFZqsiBYzFH65EenDO+ORWDUE+5kcT+lEQTu4d1roltstnue27
         M5zs3qtJNhBXleYhLjtIMUXOTktzesJsa9VwNx5WOVKKcj5OuniuOVRWHpiadYfsPvBi
         46cn5pUM3/plxEivE1gW0dd6CCvZ4cpJnDpSFbMuvBylCatqrGvYo7sEdLYPwCR2eGEb
         MPvV3meJYJBJcQxa5KNzI7ZwuUG/0lyRCW8Nols+ZXiUOL21o5NTHcnFy1gqE4tR/GFY
         zKevZIh3elUOsyc4e5a1i5Q/WvbY3287y+fBnNwAn5bgsWKkeoeevYKfF+rEGo43p+k7
         0N9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r9QyflpgjEtFsGD0y6UQIHwiwSsCeZuAWvAVlYRq76A=;
        b=SZzvr9leJMd7CoIgqUOeGgXmg1pBx9kIHXsLabaNYx7dK3eM7DdiWxfpKcX20hE3Jm
         ejXRlUIOwAmL4AVvborER3puroEgk/bIXlVEgtIWXqIPpBcM1BmqxBr7CObqlehMHo6C
         aZMTbaGaJXTgq6oA0FSHDZONCq3rSxOkL3iPtuXIw5oMp7UQwjPror76W0ZEbtvScpbj
         xCt5Xa2h+ZKWiVD24npK5Z4jsQCtvoIl3fHuivton+IfZLLgsH6CxQ9f0csnou3EL6O9
         TRYTx8sMWkCa+LHH5R64WMQN3pGeQZZK+Vjf8cppdPytTYc2skJOsEdOEfmte9+mD5g/
         yWiA==
X-Gm-Message-State: AOAM532jsD+VG+jW35BXrmEDZICnmKaZMc9A36mSpcWwfJV5FpQp/8Rk
        O2FGEP3rbJon0vPSwwM/sRk=
X-Google-Smtp-Source: ABdhPJwwWxoslApxFsiVtYkuwtL5ZI8XxhQh1o2v9BwAZLlmJGlowY9EZcAj4B1Kz4+4xJPU44qXaQ==
X-Received: by 2002:a17:90b:1e4f:: with SMTP id pi15mr10138378pjb.154.1642045962415;
        Wed, 12 Jan 2022 19:52:42 -0800 (PST)
Received: from [172.20.120.1] ([61.16.102.70])
        by smtp.gmail.com with ESMTPSA id q43sm6650023pja.29.2022.01.12.19.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 19:52:41 -0800 (PST)
Message-ID: <99bc0b86-0f57-e827-3f7a-33385f4f5003@gmail.com>
Date:   Thu, 13 Jan 2022 11:52:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH 01/13] blk: make blk-rq-qos support pluggable and modular
 policy
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, axboe@kernel.dk
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, jbacik@fb.com,
        tj@kernel.org, bvanassche@acm.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220110091046.17010-2-jianchao.wan9@gmail.com>
 <202201130903.7ZvBIOs4-lkp@intel.com>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
In-Reply-To: <202201130903.7ZvBIOs4-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/1/13 9:49 上午, kernel test robot wrote:
> ll warnings (new ones prefixed by >>):
> 
>    block/blk-iocost.c:1244:6: warning: variable 'last_period' set but not used [-Wunused-but-set-variable]
>            u64 last_period, cur_period;
>                ^
>>> block/blk-iocost.c:3348:7: warning: variable 'ioc' is uninitialized when used here [-Wuninitialized]
>            if (!ioc) {

Thanks so much
I will fix this in next patch version.

Jianchao
