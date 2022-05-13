Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A23525E5F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378571AbiEMItp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378554AbiEMItn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:49:43 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB472B0327;
        Fri, 13 May 2022 01:49:41 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w24so9154216edx.3;
        Fri, 13 May 2022 01:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9J9nqEPTUzM3UXbUgQNWRx8nTjR2V0eEMhLc72bP8hs=;
        b=qgR/dmfdIujPCPWAkFpKVe8QxZMKagJvm5HlEQSR7kVaDE2IlkWij3Rlhk2I1PGPLK
         Ot/P5qGY6JEAfS4XDs/in1tzKjtS3KcTrOmbAY6t6QlJS0U1uBSZrUKYEBRlbhDSrrTY
         ot5txIuAJQz/4s6syqrZRNm7cjloB3VKdDmgQ+ixNI+Yii2rqlZNKZmMRGDOR8Wjw5hu
         TceO91JccJaaHzndj49YNoSF7l/AoBRgdXrLj1kv7E9LimeXirXfbs1vxg1VxGEVcvzc
         zB4TbWtHpF9o1THkzIx0miwddlyLl/D09UArzmP2Kv9OsFrPU6f7eFxlF3+WJK4LBhAm
         Tu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9J9nqEPTUzM3UXbUgQNWRx8nTjR2V0eEMhLc72bP8hs=;
        b=b0vMLa4o+/OPhH1O4u+lpYehoaWj4X5Q5JmCNgBwcWzRZfx2Sup7aFq45tV8yFk2g2
         QlLlFWOPPcl00btFVeM7xrjvml+khSHX9jDF/bZWnOFQFP1XBxWKSn49XoJKNyiMiL6r
         1cI4AsQqflKIVTwHqXpgWz1gygVl2aMEJVE6NLE1Np2YfNTP6cUbhum4Rp3Gpodi3bfx
         VWsVc5uAPs4xECWaD9qnGWIg8Tk70Fg2+jIoP/+dA6FVfdP0yLVfM+WDAomDwUgWnRQj
         y8GtKgWVO8lsexPllivQ35+nihQ/e2baUXJg4mDipz0wNu0wcgJB+jsJjQ3c78z4qOCH
         ilEw==
X-Gm-Message-State: AOAM530s6OI8owJavjq/IEJMzvC3+sQ8wpCzDTg7nBZ5UMDmYGdnc2Rz
        GyFQzMN8nuM2UddxL7gtOD9YJZRuPuPYo1grszaz+dTAjoA=
X-Google-Smtp-Source: ABdhPJx9h2WPhqdcOyVYTzhGVNMvC3tgYr/4d3a3Baya0LLQWQT8z03h6OkQ4fBPsej40f72iDgeizsfao1T5bF2aTE=
X-Received: by 2002:aa7:d916:0:b0:425:d75f:ae68 with SMTP id
 a22-20020aa7d916000000b00425d75fae68mr39028168edr.270.1652431780338; Fri, 13
 May 2022 01:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220512160312.3880433-4-Qing-wu.Li@leica-geosystems.com.cn> <202205130756.Q7e8x6jf-lkp@intel.com>
In-Reply-To: <202205130756.Q7e8x6jf-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 13 May 2022 10:49:04 +0200
Message-ID: <CAHp75VdXE4f3j5yfFzpcXwhONhh0GOSGDumMWWzggD_w-voOGg@mail.gmail.com>
Subject: Re: [PATCH V5 3/5] iio: accel: sca3300: modified to support multi chips
To:     kernel test robot <lkp@intel.com>
Cc:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Tomas Melin <tomas.melin@vaisala.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild-all@lists.01.org, linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 2:30 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi LI,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on jic23-iio/togreg]
> [also build test WARNING on v5.18-rc6]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/LI-Qingwu/iio-accel-sca3300-add-compatible-for-scl3300/20220513-000857
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: arm-randconfig-c002-20220512 (https://download.01.org/0day-ci/archive/20220513/202205130756.Q7e8x6jf-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/15579266e58d7cdf4ff8e7ad7a4fa30a0bd3a589
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review LI-Qingwu/iio-accel-sca3300-add-compatible-for-scl3300/20220513-000857
>         git checkout 15579266e58d7cdf4ff8e7ad7a4fa30a0bd3a589
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/iio/accel/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    drivers/iio/accel/sca3300.c: In function 'sca3300_get_op_mode':
> >> drivers/iio/accel/sca3300.c:288:58: warning: suggest parentheses around comparison in operand of '&' [-Wparentheses]
>      288 |                 if (sca_data->chip->avail_modes_table[i] == reg_val&0x03)
>          |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~

Good catch, LKP!

>    277  static int sca3300_get_op_mode(struct sca3300_data *sca_data, int *index)
>    278  {
>    279          int reg_val;
>    280          int ret;
>    281          int i;
>    282
>    283          ret = sca3300_read_reg(sca_data, SCA3300_REG_MODE, &reg_val);
>    284          if (ret)
>    285                  return ret;
>    286

Instead, I suggest to split the below, which is invariant to the loop,
into a line here:

regval &= GENMASK(1, 0);

>    287          for (i = 0; i < sca_data->chip->num_avail_modes; i++) {
>  > 288                  if (sca_data->chip->avail_modes_table[i] == reg_val&0x03)
>    289                          break;
>    290          }
>    291
>    292          if (i >= sca_data->chip->num_avail_modes)
>    293                  return -EINVAL;
>    294
>    295          *index = i;
>    296          return 0;
>    297  }

-- 
With Best Regards,
Andy Shevchenko
