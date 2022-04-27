Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EA3510DC8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 03:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356611AbiD0BO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354034AbiD0BOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:14:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5F43ED16
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=oooHtMKG0ojECIMf2P2rwZLWBZPFRzAeQMMgbbb9SdE=; b=R4QAPnUR4EKBjNZwAib8kuam2M
        5NZELWDnuYk9hPLQwDWHH+7b8vWbavum0/Hxp622daNqVUSp6FWOnLi8DOKopA3uPT8lUB4HJx22U
        AVw0EVPRV4axSMztkR3RM+cpWfkURDTEDk0/VHecjxOlchPGiw0JZ1oN0WQS7piQ4COYbniKB2jQO
        VuUJQU3ioO93KHxEtGe1Faay9hfz//rkOHN6ttGaFOWoRUej2AO40tX5wwSyB/hRnQ+enRlw507BI
        C/zMCNW0ckwvYrmpDlTmL/Svn1UbMnYrUnNuLu7HJFG8Pther+cG0LnhghtzdYqU0fBy8/ewkjxkZ
        oljuCF9g==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njWD0-00AAT6-Bh; Wed, 27 Apr 2022 01:11:10 +0000
Message-ID: <06b10511-5c6d-686d-fc77-b4b2343fd9bc@infradead.org>
Date:   Tue, 26 Apr 2022 18:11:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: ERROR: start_text address is c000000000000500, should be
 c000000000000100
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <202204241730.Ly1j4bUG-lkp@intel.com>
Content-Language: en-US
In-Reply-To: <202204241730.Ly1j4bUG-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi bot--

On 4/24/22 02:36, kernel test robot wrote:
> Hi Randy,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   22da5264abf497a10a4ed629f07f4ba28a7ed5eb
> commit: 47c258d71ebfc832a760a1dc6540cf3c33968023 powerpc/head_check: use stdout for error messages
> date:   8 months ago
> config: powerpc64-randconfig-m031-20220424 (https://download.01.org/0day-ci/archive/20220424/202204241730.Ly1j4bUG-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=47c258d71ebfc832a760a1dc6540cf3c33968023
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 47c258d71ebfc832a760a1dc6540cf3c33968023
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> ERROR: start_text address is c000000000000500, should be c000000000000100
>>> ERROR: try to enable LD_HEAD_STUB_CATCH config option
>>> ERROR: see comments in arch/powerpc/tools/head_check.sh

# CONFIG_MODULES is not set

For this one, I didn't enable CONFIG_EXPERT and LD_HEAD_STUB_CATCH.
I just converted everything possible to be loadable modules
and that resolved the problem.

Michael- do you want any addition(s) to the head_check.sh error
messages, such as:

(a) enable CONFIG_EXPERT and LD_HEAD_STUB_CATCH
(the latter requires the former)
or (b) if CONFIG_MODULES is not enabled, enable it
and change drivers to loadable modules until the ERROR
is resolved.

-- 
~Randy
