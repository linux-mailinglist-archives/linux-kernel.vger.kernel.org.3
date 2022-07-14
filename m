Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46E75754CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiGNSRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240574AbiGNSRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:17:49 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95F968DF9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:17:48 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 6so4599183ybc.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B3qeqoAZABkkxex4KiYw4gyha/XDsYFHqm4XDsEOFxU=;
        b=pC1AAX1aado9B1UaT2DtNyupW05yhy/5eRqykgggK+WGUU5L4UeuSGqXFGx4RbZySh
         dT9p+Ioai3Yi1ACl0mYhJpsYADvsSi4dUgfs+nVhTdol+QL5dhfRnhfZOdNW860tylkc
         7jeURW/gYEvG6ktk8xs87alyuFA/MPujpAYAmwBiIaVtwc0Cle1eUYO9+mdseYj7+zzk
         1tX6HS2XixG1L4DMfy6tiKgO71fTGLSHN6QyDDNrfh++mhdtcmzF0dsD/2424AW5pdDS
         29WuttjB+kiZMN51ppzQgb0LhDcsc6s+VBjSeJH+dR56Wkw6EjUcAn0i2j4iOdsIbOPr
         kXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3qeqoAZABkkxex4KiYw4gyha/XDsYFHqm4XDsEOFxU=;
        b=11gvn/iH0g3oLNHO6ulhj12Vs8NSTWBL5eBxo5ST9CH93Omynxg3x4KEXK0YjpV/GT
         6qaOZgqRK1u9dxVLEs0uuMhcglsz1eH278bK2fvvoXl5figEgx0+7Wvo/GfbiT3TymLN
         mj40hLgrTwzN2pAsL9Tqq59AIYFr7BdOcDJHrAMB/pl/lav96kkixAh2yzMMfJBgMU8m
         +Z5281qZXDAH07LYiqnXvJB9XxhRQSxQWn6xtiZxABZHKW5hLXktKRyLpdwDvFjoLwqF
         tiLtp6CxKr+xthzamRtC0+VsU8ci621EbF/BXK4kfaXFzaEXcW985zLokmqiXplDN2SN
         d+kw==
X-Gm-Message-State: AJIora9KqTjcn2dEqg9FeVoEVVwO/NRNKbuPdVTH0vRhdh9aqWLx45ZG
        99HbBzzpL7kubzD/zolFMzUysAZ2aKemt+KmxoOkag==
X-Google-Smtp-Source: AGRyM1t0uydpjlf/L97dSFwP61Riwo45dZ5AgijM0VdruQu1Yfq+iQyXxWIvfdEym65vsNBK5d1ugq90Qr8uNdpBtE0=
X-Received: by 2002:a25:8a81:0:b0:65b:9268:2760 with SMTP id
 h1-20020a258a81000000b0065b92682760mr10205017ybl.119.1657822667466; Thu, 14
 Jul 2022 11:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220701095421.1.I78ded92e416b55de31975686d34b2058d4761c07@changeid>
 <202207020433.aSSwzWJn-lkp@intel.com> <CANkg5eyrBz9aA+ZTSBz=VeSjufPpEaNPDHNMM83V36gAM4v1VQ@mail.gmail.com>
In-Reply-To: <CANkg5eyrBz9aA+ZTSBz=VeSjufPpEaNPDHNMM83V36gAM4v1VQ@mail.gmail.com>
From:   Tim Van Patten <timvp@google.com>
Date:   Thu, 14 Jul 2022 12:17:36 -0600
Message-ID: <CANkg5ezrCdmLhH6=TS1hOHYMNeYaOCrTPM+t_Rm8-4-DXK0MEQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec: Send host event for prepare/complete
To:     kernel test robot <lkp@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kbuild-all@lists.01.org,
        robbarnes@google.com, rrangel@chromium.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Resending in plain text mode.]

Hi Guenter,

The PM subsystem doesn't print out the prepare/complete callbacks, so
we've added them to keep parity with the rest of the system that has
this output.


On Fri, Jul 1, 2022 at 3:16 PM Tim Van Patten <timvp@google.com> wrote:
>
> Hi Guenter,
>
> The PM subsystem doesn't print out the prepare/complete callbacks, so we've added them to keep parity with the rest of the system that has this output.
>
> On Fri, Jul 1, 2022 at 2:40 PM kernel test robot <lkp@intel.com> wrote:
>>
>> Hi Tim,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on chrome-platform/for-next]
>> [also build test ERROR on linus/master v5.19-rc4 next-20220701]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Tim-Van-Patten/platform-chrome-cros_ec-Send-host-event-for-prepare-complete/20220701-235602
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next
>> config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220702/202207020433.aSSwzWJn-lkp@intel.com/config)
>> compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
>> reproduce (this is a W=1 build):
>>         # https://github.com/intel-lab-lkp/linux/commit/46055ab1171506ae76daf77f7b880087c8a9119f
>>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>>         git fetch --no-tags linux-review Tim-Van-Patten/platform-chrome-cros_ec-Send-host-event-for-prepare-complete/20220701-235602
>>         git checkout 46055ab1171506ae76daf77f7b880087c8a9119f
>>         # save the config file
>>         mkdir build_dir && cp config build_dir/.config
>>         make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag where applicable
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>> >> drivers/platform/chrome/cros_ec_lpc.c:553:20: error: 'cros_ec_lpc_suspend' undeclared here (not in a function); did you mean 'cros_ec_suspend'?
>>      553 |         .prepare = cros_ec_lpc_suspend,
>>          |                    ^~~~~~~~~~~~~~~~~~~
>>          |                    cros_ec_suspend
>> >> drivers/platform/chrome/cros_ec_lpc.c:554:21: error: 'cros_ec_lpc_resume' undeclared here (not in a function); did you mean 'cros_ec_lpc_remove'?
>>      554 |         .complete = cros_ec_lpc_resume
>>          |                     ^~~~~~~~~~~~~~~~~~
>>          |                     cros_ec_lpc_remove
>>
>>
>> vim +553 drivers/platform/chrome/cros_ec_lpc.c
>>
>>    551
>>    552  static const struct dev_pm_ops cros_ec_lpc_pm_ops = {
>>  > 553          .prepare = cros_ec_lpc_suspend,
>>  > 554          .complete = cros_ec_lpc_resume
>>    555  };
>>    556
>>
>> --
>> 0-DAY CI Kernel Test Service
>> https://01.org/lkp
>
>
>
> --
>
> Tim Van Patten | ChromeOS | timvp@google.com | (720) 432-0997



-- 

Tim Van Patten | ChromeOS | timvp@google.com | (720) 432-0997
