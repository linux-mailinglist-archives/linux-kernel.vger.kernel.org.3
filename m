Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95D252BE9C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbiEROlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238707AbiEROk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:40:58 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEA8237F2
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:40:55 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id m1so1980422plx.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=whW5AxATJkNaPhkcMwvHXExGnVFe5uKOgct6URQZl5g=;
        b=CbGIorEmQCxYGxxT6P12ptGJmuJUMeLiDaJNEaORfJsQL6JEGQY5zafgphutTeIxCI
         Ut1es3HQMvL0AP1lrqqCY3V49+KjOuy9b/sBKb6syi+deqJ+Y+CFS9H7rnA8YxN862co
         Rd4xQhbA3oj+hZuLb/a7FALGlOGaJm0M20ZKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=whW5AxATJkNaPhkcMwvHXExGnVFe5uKOgct6URQZl5g=;
        b=oxtt3bOdjqGQr9rV06v1D4PhlxwD8yMpKkPncA5M1nTiTPfcS7yCA5zWB0W6BdMd2T
         t33UhbFk1ZltpBts1UfX9M1LCMOJl+LsodcbLlOlr4PV2kyqaK1mBqUnOwBoAYtXA6xg
         gj78HBz7BJ7nPEvyYwNNNK4ISPKMPW4C6VockEfFGw6/UCz2yBrdEoTX+Kd2hYJIlydN
         HssWhlyx6DWgceMfSpEtO9f+KAFodgf3w3qJn0Bpc4KsNxxl3l0SoEaqXqR9lKFdS/BO
         vLUNkDTkvhkP6Ok/pAFZnMJBqLSh4vfpI+IV3mPlzrxi5j3X9kz1Y4mruglHEbAwZSZJ
         J4HQ==
X-Gm-Message-State: AOAM533QZwIefXU0r++xYzgOZFvXJlDYOpBTSbnGhAntld7Jxhm39a9C
        DIAypL3ohIHRHfNyDFNuUp3Bzw==
X-Google-Smtp-Source: ABdhPJxi6BpB2w+x5UbiM0DcD5h4zJd4JLNDZl6PoiWtNEvkeQJsQKjoUIcCxjgfHjR+3VH6nDKcpg==
X-Received: by 2002:a17:903:31d1:b0:159:804:e852 with SMTP id v17-20020a17090331d100b001590804e852mr27301661ple.19.1652884855095;
        Wed, 18 May 2022 07:40:55 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:a14:3166:4b67:b688])
        by smtp.gmail.com with UTF8SMTPSA id j11-20020a17090ae60b00b001d95c09f877sm1642073pjy.35.2022.05.18.07.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 07:40:54 -0700 (PDT)
Date:   Wed, 18 May 2022 07:40:52 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, kbuild-all@lists.01.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4 2/3] LoadPin: Enable loading from trusted dm-verity
 devices
Message-ID: <YoUFdBbwAvq71fQW@google.com>
References: <20220517163437.v4.2.I01c67af41d2f6525c6d023101671d7339a9bc8b5@changeid>
 <202205181616.3eTP2DaC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202205181616.3eTP2DaC-lkp@intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 04:58:06PM +0800, kernel test robot wrote:
> Hi Matthias,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on device-mapper-dm/for-next]
> [also build test WARNING on song-md/md-next kees/for-next/pstore linus/master v5.18-rc7 next-20220517]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Matthias-Kaehlcke/LoadPin-Enable-loading-from-trusted-dm-verity-devices/20220518-073635
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git for-next
> config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220518/202205181616.3eTP2DaC-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/755e5d82e4d054b2b58a54c94681080cc8cb4582
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Matthias-Kaehlcke/LoadPin-Enable-loading-from-trusted-dm-verity-devices/20220518-073635
>         git checkout 755e5d82e4d054b2b58a54c94681080cc8cb4582
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash security/loadpin/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from security/loadpin/loadpin.c:21:
>    include/linux/dm-verity-loadpin.h:22:1: error: expected identifier or '(' before '{' token
>       22 | {
>          | ^
> >> include/linux/dm-verity-loadpin.h:21:20: warning: 'dm_verity_loadpin_is_sb_trusted' used but never defined
>       21 | static inline bool dm_verity_loadpin_is_sb_trusted(struct super_block *sb);
>          |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +/dm_verity_loadpin_is_sb_trusted +21 include/linux/dm-verity-loadpin.h
> 
> afd03270f57b8c Matthias Kaehlcke 2022-05-17  17  
> afd03270f57b8c Matthias Kaehlcke 2022-05-17  18  #if IS_ENABLED(CONFIG_SECURITY_LOADPIN) && IS_BUILTIN(CONFIG_DM_VERITY)
> afd03270f57b8c Matthias Kaehlcke 2022-05-17  19  bool dm_verity_loadpin_is_sb_trusted(struct super_block *sb);
> afd03270f57b8c Matthias Kaehlcke 2022-05-17  20  #else
> afd03270f57b8c Matthias Kaehlcke 2022-05-17 @21  static inline bool dm_verity_loadpin_is_sb_trusted(struct super_block *sb);
> afd03270f57b8c Matthias Kaehlcke 2022-05-17 @22  {
> afd03270f57b8c Matthias Kaehlcke 2022-05-17  23  	return false;
> afd03270f57b8c Matthias Kaehlcke 2022-05-17  24  }
> afd03270f57b8c Matthias Kaehlcke 2022-05-17  25  #endif
> afd03270f57b8c Matthias Kaehlcke 2022-05-17  26  

Oops, will fix
