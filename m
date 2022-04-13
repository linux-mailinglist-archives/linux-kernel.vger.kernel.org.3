Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9517450024C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbiDMXK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiDMXKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:10:23 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE2B25C4C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:08:00 -0700 (PDT)
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1nelpW-0002n1-Cw; Thu, 14 Apr 2022 00:51:18 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1nelpW-000AyP-7e; Thu, 14 Apr 2022 00:51:18 +0200
Subject: Re: [ammarfaizi2-block:bpf/bpf-next/pr/bpf-sysctl 1/1]
 kernel/bpf/syscall.c:4944:13: warning: no previous prototype for
 'unpriv_ebpf_notify'
To:     kernel test robot <lkp@intel.com>, Yan Zhu <zhuyan34@huawei.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
References: <202204140614.Tt9e1fIt-lkp@intel.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <bb65135e-035b-b82e-f75c-236a4ec72923@iogearbox.net>
Date:   Thu, 14 Apr 2022 00:51:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <202204140614.Tt9e1fIt-lkp@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26511/Wed Apr 13 10:22:45 2022)
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 12:42 AM, kernel test robot wrote:
> tree:   https://github.com/ammarfaizi2/linux-block bpf/bpf-next/pr/bpf-sysctl
> head:   2900005ea287b11dcc8c1b9fcf24893b7ff41d6d
> commit: 2900005ea287b11dcc8c1b9fcf24893b7ff41d6d [1/1] bpf: Move BPF sysctls from kernel/sysctl.c to BPF core
> config: sh-buildonly-randconfig-r001-20220413 (https://download.01.org/0day-ci/archive/20220414/202204140614.Tt9e1fIt-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/ammarfaizi2/linux-block/commit/2900005ea287b11dcc8c1b9fcf24893b7ff41d6d
>          git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>          git fetch --no-tags ammarfaizi2-block bpf/bpf-next/pr/bpf-sysctl
>          git checkout 2900005ea287b11dcc8c1b9fcf24893b7ff41d6d
>          # save the config file to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>     sh4-linux-ld: arch/sh/lib/mcount.o: in function `stack_panic':
>>> (.text+0x50): undefined reference to `dump_stack'
> --
>>> kernel/bpf/syscall.c:4944:13: warning: no previous prototype for 'unpriv_ebpf_notify' [-Wmissing-prototypes]
>      4944 | void __weak unpriv_ebpf_notify(int new_state)
>           |             ^~~~~~~~~~~~~~~~~~
> 
> 
> vim +/unpriv_ebpf_notify +4944 kernel/bpf/syscall.c
> 
>    4943	
>> 4944	void __weak unpriv_ebpf_notify(int new_state)
>    4945	{
>    4946	}
>    4947	
> 

(Note that this is no different than the way it was before wrt prototype.)
