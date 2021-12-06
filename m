Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B40646A6E6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349729AbhLFUgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:36:42 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51762 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbhLFUgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:36:37 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id EE4CA20E6F24;
        Mon,  6 Dec 2021 12:33:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EE4CA20E6F24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1638822788;
        bh=Pa85wFpOW3aieOalRg1XsiYixZMn9Dk7XTKB5+tQi6g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OYC9cYheHHGDt3NHD9710L49M/6W/Be+U4wnz0m1tvUq4E+4ZxmTDJC8l3wdXOz6M
         GexAWbZNdGKyaDmssJsuzOWPOpSBs3gK+zeSayzRtEPPVZFLFKWxBRSc3NfSCGaKK/
         6pJcurH1hlp1qlUMSCrDOAxL+KlaP/vIjm/ZCMXE=
Message-ID: <29aa717b-a862-e6b0-0286-9dd948968efa@linux.microsoft.com>
Date:   Mon, 6 Dec 2021 12:33:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: arch/arm64/kernel/machine_kexec_file.c:152 load_other_segments()
 warn: missing error code 'ret'
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
References: <202111280304.FL2314qf-lkp@intel.com>
 <CAL_JsqKzsCvS2QKUo7x4eJ2s6p4=3_d38hyMvsVt7RySjHoGgw@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
In-Reply-To: <CAL_JsqKzsCvS2QKUo7x4eJ2s6p4=3_d38hyMvsVt7RySjHoGgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes Rob - will do it this week.

thanks,
  -lakshmi

On 12/6/2021 12:31 PM, Rob Herring wrote:
> On Wed, Dec 1, 2021 at 5:47 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   c5c17547b778975b3d83a73c8d84e8fb5ecf3ba5
>> commit: ac10be5cdbfa852139658d52c2f1c608782ce992 arm64: Use common of_kexec_alloc_and_setup_fdt()
>> config: arm64-randconfig-m031-20211127 (https://download.01.org/0day-ci/archive/20211128/202111280304.FL2314qf-lkp@intel.com/config)
>> compiler: aarch64-linux-gcc (GCC) 11.2.0
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>
>> smatch warnings:
>> arch/arm64/kernel/machine_kexec_file.c:152 load_other_segments() warn: missing error code 'ret'
> 
> Lakshmi, Can you please prepare a fix for this. It's been reported since July.
> 
>>
>> vim +/ret +152 arch/arm64/kernel/machine_kexec_file.c
>>
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15   81  int load_other_segments(struct kimage *image,
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15   82                          unsigned long kernel_load_addr,
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15   83                          unsigned long kernel_size,
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15   84                          char *initrd, unsigned long initrd_len,
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15   85                          char *cmdline)
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15   86  {
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15   87          struct kexec_buf kbuf;
>> 3751e728cef290 AKASHI Takahiro         2019-12-16   88          void *headers, *dtb = NULL;
>> 108aa503657ee2 Benjamin Gwin           2020-11-03   89          unsigned long headers_sz, initrd_load_addr = 0, dtb_len,
>> 108aa503657ee2 Benjamin Gwin           2020-11-03   90                        orig_segments = image->nr_segments;
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15   91          int ret = 0;
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15   92
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15   93          kbuf.image = image;
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15   94          /* not allocate anything below the kernel */
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15   95          kbuf.buf_min = kernel_load_addr + kernel_size;
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15   96
>> 3751e728cef290 AKASHI Takahiro         2019-12-16   97          /* load elf core header */
>> 3751e728cef290 AKASHI Takahiro         2019-12-16   98          if (image->type == KEXEC_TYPE_CRASH) {
>> 3751e728cef290 AKASHI Takahiro         2019-12-16   99                  ret = prepare_elf_headers(&headers, &headers_sz);
>> 3751e728cef290 AKASHI Takahiro         2019-12-16  100                  if (ret) {
>> 3751e728cef290 AKASHI Takahiro         2019-12-16  101                          pr_err("Preparing elf core header failed\n");
>> 3751e728cef290 AKASHI Takahiro         2019-12-16  102                          goto out_err;
>> 3751e728cef290 AKASHI Takahiro         2019-12-16  103                  }
>> 3751e728cef290 AKASHI Takahiro         2019-12-16  104
>> 3751e728cef290 AKASHI Takahiro         2019-12-16  105                  kbuf.buffer = headers;
>> 3751e728cef290 AKASHI Takahiro         2019-12-16  106                  kbuf.bufsz = headers_sz;
>> 3751e728cef290 AKASHI Takahiro         2019-12-16  107                  kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>> 3751e728cef290 AKASHI Takahiro         2019-12-16  108                  kbuf.memsz = headers_sz;
>> 3751e728cef290 AKASHI Takahiro         2019-12-16  109                  kbuf.buf_align = SZ_64K; /* largest supported page size */
>> 3751e728cef290 AKASHI Takahiro         2019-12-16  110                  kbuf.buf_max = ULONG_MAX;
>> 3751e728cef290 AKASHI Takahiro         2019-12-16  111                  kbuf.top_down = true;
>> 3751e728cef290 AKASHI Takahiro         2019-12-16  112
>> 3751e728cef290 AKASHI Takahiro         2019-12-16  113                  ret = kexec_add_buffer(&kbuf);
>> 3751e728cef290 AKASHI Takahiro         2019-12-16  114                  if (ret) {
>> 3751e728cef290 AKASHI Takahiro         2019-12-16  115                          vfree(headers);
>> 3751e728cef290 AKASHI Takahiro         2019-12-16  116                          goto out_err;
>> 3751e728cef290 AKASHI Takahiro         2019-12-16  117                  }
>> 7b558cc3564e6c Lakshmi Ramasubramanian 2021-02-21  118                  image->elf_headers = headers;
>> 7b558cc3564e6c Lakshmi Ramasubramanian 2021-02-21  119                  image->elf_load_addr = kbuf.mem;
>> 7b558cc3564e6c Lakshmi Ramasubramanian 2021-02-21  120                  image->elf_headers_sz = headers_sz;
>> 3751e728cef290 AKASHI Takahiro         2019-12-16  121
>> 3751e728cef290 AKASHI Takahiro         2019-12-16  122                  pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>> 7b558cc3564e6c Lakshmi Ramasubramanian 2021-02-21  123                           image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
>> 3751e728cef290 AKASHI Takahiro         2019-12-16  124          }
>> 3751e728cef290 AKASHI Takahiro         2019-12-16  125
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15  126          /* load initrd */
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15  127          if (initrd) {
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15  128                  kbuf.buffer = initrd;
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15  129                  kbuf.bufsz = initrd_len;
>> c19d050f808812 Bhupesh Sharma          2019-07-11  130                  kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15  131                  kbuf.memsz = initrd_len;
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15  132                  kbuf.buf_align = 0;
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15  133                  /* within 1GB-aligned window of up to 32GB in size */
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15  134                  kbuf.buf_max = round_down(kernel_load_addr, SZ_1G)
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15  135                                                  + (unsigned long)SZ_1G * 32;
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15  136                  kbuf.top_down = false;
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15  137
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15  138                  ret = kexec_add_buffer(&kbuf);
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15  139                  if (ret)
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15  140                          goto out_err;
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15  141                  initrd_load_addr = kbuf.mem;
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15  142
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15  143                  pr_debug("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>> 51075e0cb759a7 Łukasz Stelmach         2020-04-30  144                                  initrd_load_addr, kbuf.bufsz, kbuf.memsz);
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15  145          }
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15  146
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15  147          /* load dtb */
>> ac10be5cdbfa85 Rob Herring             2021-02-21  148          dtb = of_kexec_alloc_and_setup_fdt(image, initrd_load_addr,
>> ac10be5cdbfa85 Rob Herring             2021-02-21  149                                             initrd_len, cmdline, 0);
>> ac10be5cdbfa85 Rob Herring             2021-02-21  150          if (!dtb) {
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15  151                  pr_err("Preparing for new dtb failed\n");
>> 52b2a8af743604 AKASHI Takahiro         2018-11-15 @152                  goto out_err;
>>                                                                          ^^^^^^^^^^^^^
>> This needs an error code.
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>
