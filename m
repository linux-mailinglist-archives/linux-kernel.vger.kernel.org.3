Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E16A52CD14
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbiESHba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbiESHb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:31:27 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF4130F7D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:31:26 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id s14so4038310plk.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OwZHQWeHwkceIr3VPipXqZlSRdGU9Cp44aK09dkAXQ4=;
        b=ZfrlKzFubXl7Ax5rrOTUWAD6WI9V00fCklFg2MD3EIMDXt/PtQjRbT26EHodNSpTNV
         AX9Aer1pwoT0ikA70AULQvI5kKBX57JJHKPslNI3MtZ6F9ITCfsGN/mszWWDHnj+BTk/
         98x/aMgMtQPYV9znZWBh9LexcUXhKgxxFX6RYlAIylFiw1YAj+gLFGo4x3hEGgX+nGSV
         wIGQ9JSsXhg10zJtfZg/+pW19vg9sTFH1M4mWjxTZ4JjE6o6vhknwn4IksH8YhRmgsH6
         kPUhd0l9TkMWys7yaR2K91dV7IqoUpGmZ5eEzt8YgNHxuGA7UmqQIjaZCPCbIRoAja/c
         O0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OwZHQWeHwkceIr3VPipXqZlSRdGU9Cp44aK09dkAXQ4=;
        b=vzFGo0Eku9Z0BFWXganldrd07zyexn39QGguxXCgxvnqErYo6kqPDj80LZvHzH8ZXo
         fESYq93CDufkWwK94/bfE++ucdb+F82HrGG5Fb4Kc/qZ/12QVKtcbJvIZFOlUf8kEZRd
         lvTuPWYYWXIVR/5UTEI5GSQnp07ce0qPN+oSPAAueWB/TigKsO+5sj8uWKdHg1ECpseJ
         lKvt9eZe3yhSkUDsbne5W09chcTIavpbiW2TJ4qulLWacPU8fE0z8ofskbndAC0e6LcB
         xvXfQIDexPh87OYKdK7BzieTqit6Y7/hY2Sn15xeJMWBFPbk3XEIx6PKnKgjkIlS5ng4
         2RMQ==
X-Gm-Message-State: AOAM53248bgUn7PjEt0bxKtc/QCJVfhD9WqxgSRRnHuCLTcnjLJBqm07
        GqnnaxOPGAIQ1shzCfIBR9Sv5Q7IXbhoMBgOEqJF9g==
X-Google-Smtp-Source: ABdhPJx02nFN2qgr+o8vGAgbIUFFcbcCpjZpAllvzp+6oTibISA0iFbIS9uLs92u2/tRzTq/Ks6EdvlCCkk7q7e48lc=
X-Received: by 2002:a17:90a:4209:b0:1df:b907:ed3d with SMTP id
 o9-20020a17090a420900b001dfb907ed3dmr3808743pjg.40.1652945485756; Thu, 19 May
 2022 00:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220519032108.2996400-1-yangyingliang@huawei.com>
In-Reply-To: <20220519032108.2996400-1-yangyingliang@huawei.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Thu, 19 May 2022 09:30:49 +0200
Message-ID: <CAMZdPi8E7pMR22SyXbtCe5Wtb-jLfF-ZD+-qEAW5KFiJ6FP6Pg@mail.gmail.com>
Subject: Re: [PATCH -next v2] net: wwan: t7xx: use GFP_ATOMIC under spin lock
 in t7xx_cldma_gpd_set_next_ptr()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        haijun.liu@mediatek.com, chandrashekar.devegowda@intel.com,
        ricardo.martinez@linux.intel.com, davem@davemloft.net,
        kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2022 at 05:10, Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> Sometimes t7xx_cldma_gpd_set_next_ptr() is called under spin lock,
> so add 'gfp_mask' parameter in t7xx_cldma_gpd_set_next_ptr() to pass
> the flag.
>
> Fixes: 39d439047f1d ("net: wwan: t7xx: Add control DMA interface")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
