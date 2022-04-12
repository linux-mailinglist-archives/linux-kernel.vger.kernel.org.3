Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C2B4FC93E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 02:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241222AbiDLA0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 20:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237169AbiDLA0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 20:26:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BC41A398;
        Mon, 11 Apr 2022 17:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649723027; x=1681259027;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=esdIpnRDU/bgclFf4eXQIx1uxSu3UFkWu9WM9un83+I=;
  b=Bm8glr1CH3f31NDNvcuEUszqjvJjTwckWXoNrhAwkEACTSkc3aLc2lcP
   s7359F5Y88iHsfetTCVdP3syQcvWPTwGJFkVdE3jYzDIH4u+j/1X8GF+9
   0zhSGx34zlXxo/v6Jjiwwe4+b8S2ZaN9W1Gf7TXRRR/wcHVC02cVLjn5X
   fWE7r7taRqvexI2imR7BOtY/jajlF4tHf1TpIk7zjLqhe9jOfjI2uhqgU
   nycLlNOxHzD5CdsWRmeqfXVKgUjKKUi6YIpCniQxk3ms3QdAzGEsPcwM4
   hYqAmujwTG0/uqmmUlBEaPzxFSrlqf1wcGTkdkhHq8LQjf1q4SOPli5Ub
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261683585"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="261683585"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 17:23:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="660260014"
Received: from zhoufuro-mobl.ccr.corp.intel.com (HELO [10.249.171.224]) ([10.249.171.224])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 17:23:43 -0700
Message-ID: <0957e2ef-2483-375d-e2bf-6dae4fa2e6b3@linux.intel.com>
Date:   Tue, 12 Apr 2022 08:23:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 0/3] Add SMP/SMT support for Ingenic sysost driver.
Content-Language: en-US
To:     =?UTF-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>, daniel.lezcano@linaro.org,
        tglx@linutronix.de, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
References: <1649687597-74219-1-git-send-email-zhouyanjie@wanyeetech.com>
From:   Zhou Furong <furong.zhou@linux.intel.com>
In-Reply-To: <1649687597-74219-1-git-send-email-zhouyanjie@wanyeetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

On 2022/4/11 22:33, 周琰杰 (Zhou Yanjie) wrote:
> 1.On the hardware of X2000 SoC, the OST has been split into
>    two parts, two 32bit timers for clockevent and one 64bit
>    timer for clocksource (with different addresses), so it
>    not appropriate to use only one "ingenic,x2000-ost", just
>    remove it, then introduce "ingenic,x2000-ost32" and
>    "ingenic,x2000-ost64".
> 2.The OST in Ingenic XBurst®2 SoCs has a global timer and
>    up to 16 event timers, add support for the event timers.
> 3.Add dt-bindings and compatible strings for the X1600 SoC,
>    the X1700 SoC, the X1830 SoC, the X2000 SoC, the X2500 SoC.
> 
> 周琰杰 (Zhou Yanjie) (3):
Please consider config your git, Non-english characters may not always 
display correctly.



Best regards,
Furong
