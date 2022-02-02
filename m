Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3154A7902
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 20:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347052AbiBBTxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 14:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiBBTxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 14:53:05 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03EDC061714;
        Wed,  2 Feb 2022 11:53:05 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id y23so319997oia.13;
        Wed, 02 Feb 2022 11:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KAapnjqdupg9fXil76Py0BtdEYN3g3+SW5GIOZidvYY=;
        b=CDBJpW2r1wf4eigdGkr2V3IrvGBF1xzJPfbz1cW8hvexOIc3Bqqe2/aFWwOiZhIob7
         RfmtODcRYQU9+t+pXV5KC+16mpLpvgFFM5bBgmyDMjzeTayORc8VAAxcAiLcyst9P+lW
         LNP8llOOPsky8AS5TlwYipDYeti9NR7W6RJXTG7oFxkO9/krL9RfkSFZ/Wiju7HRuICK
         g8HabQbbuwEICZ/yuQAJ1p4tt45PJxg2T7E925GUcuNAFcn4mTHbBUpKcAe4derklUOn
         9o/QA6wojlmX6EC4x/7nP+OT99lV+r50AjkCvEhtiJuFpic1nIM+VGgtLGHHWydu69jO
         9wIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=KAapnjqdupg9fXil76Py0BtdEYN3g3+SW5GIOZidvYY=;
        b=1/fOapZxFirxd77fkIxFtUPzl5vASO8BuLZYrqTGpkpFTXJx4n5zcKpmiwvotCI50B
         DtkFlO+qzYKaFwWurpOKvLyAMHOr20CvvlfErOToyZV9RR9F+m054D53shr7N2kpW98C
         Zl1kJ56Z0Xl0Vi3HAvwFDW1iklNYpAxABl2+knkI+slM7+fQRESY2dk2hGb0UxvTq+Sx
         7Xg3cpbeUM0Ud2LZCUU7GxA0PwuThAYyhZz1in1U21H/pvMB7RaHGbaFzjNvCoiYnAFK
         wjVyTV4UZedjlg+76SipSH1DHuQT5c04HoryZ2nQAxGQookb3+34aH9p9SeETdGhnJbv
         P0/Q==
X-Gm-Message-State: AOAM530NAOnxRDFfT2D9V1JB/IqCz6UUK8cg6KLWwdCfN+weZoXqokdx
        81N7BMlHKoFERIROrZyjbaAAPY2qtsPxMQ==
X-Google-Smtp-Source: ABdhPJxvw0En4YbOUz5a0ijavlnDr7FTM+Drf8Cy32SojnkMJ1wqRLvIcSilLwtGWf55xTxvUfQkOA==
X-Received: by 2002:a05:6808:1490:: with SMTP id e16mr5756692oiw.8.1643831585077;
        Wed, 02 Feb 2022 11:53:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l38sm17889158otl.45.2022.02.02.11.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 11:53:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Feb 2022 11:53:03 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     kernel test robot <lkp@intel.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        kbuild-all@lists.01.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] usb: typec: Factor out non-PD fwnode properties
Message-ID: <20220202195303.GE2346468@roeck-us.net>
References: <20220201032440.5196-3-samuel@sholland.org>
 <202202021458.xcH4F4SQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202021458.xcH4F4SQ-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 02:22:27PM +0800, kernel test robot wrote:
> Hi Samuel,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on usb/usb-testing]
> [also build test WARNING on robh/for-next v5.17-rc2 next-20220202]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Samuel-Holland/dt-bindings-vendor-prefixes-Add-willsemi/20220201-112541
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> config: openrisc-randconfig-m031-20220201 (https://download.01.org/0day-ci/archive/20220202/202202021458.xcH4F4SQ-lkp@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 11.2.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> smatch warnings:
> drivers/usb/typec/class.c:1919 typec_get_fw_cap() warn: unsigned 'cap->type' is never less than zero.
> drivers/usb/typec/class.c:1926 typec_get_fw_cap() warn: unsigned 'cap->data' is never less than zero.
> 

Ah yes, there was a reason to assign the return values to 'ret' first
and only afterwards to the actual capabilities. Please fix and resubmit.

Guenter
