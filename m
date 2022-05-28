Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4926E536B8B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 10:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbiE1IBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 04:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiE1IBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 04:01:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93C11FB
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 01:01:17 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nurNe-0002bB-Am; Sat, 28 May 2022 10:01:02 +0200
Message-ID: <9f278f81-1125-8c54-8f37-922e7b2129a9@pengutronix.de>
Date:   Sat, 28 May 2022 10:00:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: kismet: WARNING: unmet direct dependencies detected for
 CRYPTO_DEV_FSL_CAAM_BLOB_GEN when selected by TRUSTED_KEYS_CAAM
To:     kernel test robot <lkp@intel.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Gstir <david@sigma-star.at>,
        Pankaj Gupta <pankaj.gupta@nxp.com>
References: <202205281527.o6zXpTYo-lkp@intel.com>
Content-Language: en-US
In-Reply-To: <202205281527.o6zXpTYo-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28.05.22 09:42, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9d004b2f4fea97cde123e7f1939b80e77bf2e695
> commit: e9c5048c2de1913d0bcd589bc1487810c2e24bc1 KEYS: trusted: Introduce support for NXP CAAM-based trusted keys
> date:   5 days ago
> config: (https://download.01.org/0day-ci/archive/20220528/202205281527.o6zXpTYo-lkp@intel.com/config)
> reproduce:
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e9c5048c2de1913d0bcd589bc1487810c2e24bc1
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout e9c5048c2de1913d0bcd589bc1487810c2e24bc1
>         # 1. reproduce by kismet
>            # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
>            kismet --linux-ksrc=linux --selectees CONFIG_CRYPTO_DEV_FSL_CAAM_BLOB_GEN --selectors CONFIG_TRUSTED_KEYS_CAAM -a=arm64
>         # 2. reproduce by make
>            # save the config file to linux source tree
>            cd linux
>            make ARCH=arm64 olddefconfig
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> kismet warnings: (new ones prefixed by >>)
>>> kismet: WARNING: unmet direct dependencies detected for CRYPTO_DEV_FSL_CAAM_BLOB_GEN when selected by TRUSTED_KEYS_CAAM

The referenced config file doesn't have anything CAAM related enabled.

I looked again at the Kconfig and CRYPTO_DEV_FSL_CAAM_BLOB_GEN depends on
CRYPTO_DEV_FSL_CAAM_JR. TRUSTED_KEYS_CAAM depends on
CRYPTO_DEV_FSL_CAAM_JR >= TRUSTED_KEYS and only then selects
CRYPTO_DEV_FSL_CAAM_BLOB_GEN, which still looks correct to me.

Could one of the authors elaborate what issue is being reported here?

Cheers,
Ahmad

> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
