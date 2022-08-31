Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822D95A7335
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 03:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiHaBJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 21:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiHaBJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 21:09:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3448AE9FA
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:09:36 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MHQwM4rgJzkWjS;
        Wed, 31 Aug 2022 09:05:55 +0800 (CST)
Received: from [10.67.110.83] (10.67.110.83) by canpemm500006.china.huawei.com
 (7.192.105.130) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 31 Aug
 2022 09:09:34 +0800
Subject: Re: ping //Re: [PATCH v2 0/2] squashfs: Add the mount parameter
 "threads="
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        <linux-kernel@vger.kernel.org>
CC:     <wangle6@huawei.com>, <yi.zhang@huawei.com>,
        <wangbing6@huawei.com>, <zhongjubin@huawei.com>,
        <chenjianguo3@huawei.com>
References: <20220815031100.75243-1-nixiaoming@huawei.com>
 <20220816010052.15764-1-nixiaoming@huawei.com>
 <8d139f03-7845-9c96-fffc-74fdf8b5d78d@huawei.com>
 <60b24133-234f-858b-8e71-e183fe72d2bb@squashfs.org.uk>
 <9c5bddc3-fc93-d76a-1163-0278c8d31dc5@huawei.com>
 <74fb0469-e593-ed0e-3f9b-5ec535969c78@squashfs.org.uk>
 <ab006c5e-1729-3e46-0daa-0df43a05a88b@squashfs.org.uk>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <52b7e12a-80ce-767e-f677-eda7a5e9801a@huawei.com>
Date:   Wed, 31 Aug 2022 09:09:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <ab006c5e-1729-3e46-0daa-0df43a05a88b@squashfs.org.uk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.83]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/31 2:34, Phillip Lougher wrote:
> On 30/08/2022 19:08, Phillip Lougher wrote:
>> On 30/08/2022 14:38, Xiaoming Ni wrote:
>>> On 2022/8/29 7:18, Phillip Lougher wrote:
> 
>>>> As regards points 1 - 3, personally I would add a default kernel
>>>> configuration option that keeps the existing behaviour, build time
>>>> selectable only, no additional mount time options.  Then a
>>>> kernel configuration option that allows the different decompressors
>>>> to be selected at mount time, but which always builds all the
>>>> decompressors.  This will avoid the silliness of point 2, and
>>> Would it be better to allow flexible selection of decompression mode 
>>> combinations?
>>
>> I told you I don't like that (*).  I also told you I want the default 
>> behaviour to be the current behaviour.
>>
>> Feel free to disagree, but that isn't a good way to get your patch
>> reviewed or accepted by me.
>>
>> Cheers
>>
>> Phillip
>>
>> (*) Adding options to select the decompressor at mount time, but,
>>      also allowing only 1 - 2 decompressors to be built is a waste of
>>      time.  It has the effect of giving something with one hand and
>>      taking it alway with the other.  Build the lot, this also
>>      keeps it simple.
>>
>>
> 
> It also splatters super.c with #ifdef CONFIG lines.
> 
> phillip@phoenix:/external/stripe/linux/fs/squashfs$ grep "CONFIG_" super.c
> #ifdef CONFIG_SQUASHFS_DECOMP_SINGLE
> #ifdef CONFIG_SQUASHFS_DECOMP_MULTI
> #ifdef CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU
> #ifdef CONFIG_SQUASHFS_DECOMP_SINGLE
> #ifdef CONFIG_SQUASHFS_DECOMP_MULTI
> #ifdef CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU
> #ifdef CONFIG_SQUASHFS_DECOMP_DEFAULT_SINGLE
> #elif defined(CONFIG_SQUASHFS_DECOMP_DEFAULT_MULTI)
> #elif defined(CONFIG_SQUASHFS_DECOMP_DEFAULT_PERCPU)
> 
> Or
> 
> static int squashfs_parse_param_threads(const char *str, struct 
> squashfs_mount_opts *opts)
> {
>          unsigned long num;
>          int ret;
> #ifdef CONFIG_SQUASHFS_DECOMP_SINGLE
>          if (strcmp(str, "single") == 0) {
>                  opts->thread_ops = &squashfs_decompressor_single;
>                  return 0;
>          }
> #endif
> #ifdef CONFIG_SQUASHFS_DECOMP_MULTI
>          if (strcmp(str, "multi") == 0) {
>                  opts->thread_ops = &squashfs_decompressor_multi;
>                  return 0;
>          }
> #endif
> #ifdef CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU
>          if (strcmp(str, "percpu") == 0) {
>                  opts->thread_ops = &squashfs_decompressor_percpu;
>                  return 0;
>          }
> #endif
>          ret = kstrtoul(str, 0, &num);
>          if (ret != 0 || num == 0)
>                  return -EINVAL;
> #ifdef CONFIG_SQUASHFS_DECOMP_SINGLE
>          if (num == 1) {
>                  opts->thread_ops = &squashfs_decompressor_single;
>                  return 0;
>          }
> #endif
> #ifdef CONFIG_SQUASHFS_DECOMP_MULTI
>          opts->thread_ops = &squashfs_decompressor_multi;
>          if (num > opts->thread_ops->max_decompressors())
>                  num = opts->thread_ops->max_decompressors();
>          opts->thread_num = (int)num;
>          return 0;
> #else
>          return -EINVAL;
> #endif
> }
> 
> SNIP
> 
> static int squashfs_show_options(struct seq_file *s, struct dentry *root)
> {
>          struct super_block *sb = root->d_sb;
>          struct squashfs_sb_info *msblk = sb->s_fs_info;
> 
>          if (msblk->panic_on_errors)
>                  seq_puts(s, ",errors=panic");
>          else
>                  seq_puts(s, ",errors=continue");
> 
> #ifdef CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU
>          /*
>           * thread=percpu and thread=<number> have different 
> configuration effects.
>           * the parameters need to be treated differently when they are 
> displayed.
>           */
>          if (msblk->thread_ops == &squashfs_decompressor_percpu) {
>                  seq_puts(s, ",threads=percpu");
>                  return 0;
>          }
> #endif
>          seq_printf(s, ",threads=%u", msblk->max_thread_num);
>          return 0;
> }
> 
> static int squashfs_init_fs_context(struct fs_context *fc)
> {
>          struct squashfs_mount_opts *opts;
> 
>          opts = kzalloc(sizeof(*opts), GFP_KERNEL);
>          if (!opts)
>                  return -ENOMEM;
> 
> #ifdef CONFIG_SQUASHFS_DECOMP_DEFAULT_SINGLE
>          opts->thread_ops = &squashfs_decompressor_single;
> #elif defined(CONFIG_SQUASHFS_DECOMP_DEFAULT_MULTI)
>          opts->thread_ops = &squashfs_decompressor_multi,
> #elif defined(CONFIG_SQUASHFS_DECOMP_DEFAULT_PERCPU)
>          opts->thread_ops = &squashfs_decompressor_percpu;
> #endif
> 
> 
Thanks for your guidance, I will update it in v3 patch as soon as possible

Thanks

Xiaoming Ni


