Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA84503410
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiDPCHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiDPCGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:06:03 -0400
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D8F6D4E5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 18:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1650074332;
        bh=CriwDWtOWAQX5VANr5fAIAkGQbBAnagbCEroVjZL5xE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NTRnOIaHyemr/JoHOXrNcIwV+urI6oIdsGlqBmMV7bxymwyVaIdf0dcpXbodWKjI1
         6bmhN6NuqwVtHhxsdJoJjJUncKPGcBWgbbxn+XfgWDl3v99oZsz47JRo3i3VdMAkkb
         BnFNbS5f/wrLjxHneUqI730/6Vm3QDb4qQY0HjzI=
Received: from [IPv6:240e:362:47d:9500:6527:51dc:8ce2:179e] ([240e:362:47d:9500:6527:51dc:8ce2:179e])
        by newxmesmtplogicsvrszc7.qq.com (NewEsmtp) with SMTP
        id AD38087B; Sat, 16 Apr 2022 09:43:19 +0800
X-QQ-mid: xmsmtpt1650073399tvl7nvia6
Message-ID: <tencent_8EC09A26D25C1A263AE207952230B789D409@qq.com>
X-QQ-XMAILINFO: NY3HYYTs4gYSrO+zHxGJ/iwzNSjLXu9vUBN6PnZHIBGTm9jqMKPbKBgmf1wIfN
         fUnS32uHdLgy3E17MQn5nFZSjeuCUdYakAG0ji4xpE2GYKNVYpdnhhiMAyVYLaYzjVramRVd2o6T
         PBKHwjgnLhPCmooQY8Laqj4OEKZkrHDUYaNs6LU0sl3pPhLu9tkGtd7ookVkvph0+UidYKAunvTl
         z64mBPOAzGtjKjINLBHRpyPODP9pwo///ZZYbqaX/8sZ9yXWUo65C/WPy8YoOlqhnHs8VqUSMZLP
         h7/QcFSpSabezlKuABc/Wc/pjNosbHwzpDVAWJ9XolbEH93SZPppBI5AMRueJubQh+/vV6hHOKHR
         Y+AFXbM4k/ES7/0nxIZfWygx2H4lW7tefGlAaGII6lLDYSSHCqfjVpmrGKkY0Zd2TU6QlpNrSD7O
         7QWzcDuxN6wQUBngabozrXDxiyeXEpoclQka7rTkMp3+/5Euph5yL1mqelcqQunVwmuPTv1w+iUz
         WxAGWWWQkwg/8dzxw/NdUDUzSo5OWhYFlYkxLLzlDLZMUMIehLrrF0+gLFfGbzUkF5RS7a8q3IJb
         8lrJzBymc56Fn/tztPziAJBerWZxZ3+c8tF7zcBjUZP9dSZNb2blYQZw+VVvxDTb5igATok3q35O
         6PIQGZkUpGXIW5e0/M9ZEfI1eTTEzcQ2lopQigFZnhNAZ3lu/1+4jc8P1v8uJC/hezPlSX1BKFvi
         y6O5YlLO9pbmg+Zu0uqrecPrFhfwamuTbcuYhgHZyxEY6aPA64xzsL7ESon5Rrz4jL1z08ULC3CU
         xNAp8smcjAtTgyp37Z+QYLn5SKilhvPcZx5jn3ME9bKAuWX6oh4QE/+ASY50DPki7FRfUaqp60rk
         63jl0c74ddlK+VrqzWWIu0WF629TKIDoj/id2Z1rgmyE8kz20Viyu9zOXNU+hmCMecUiG/Xh/ZsB
         y5FqaZTq2OEsJN4wfz7Q==
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        jean-philippe <jean-philippe@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com>
 <99bcb9f5-4776-9c40-a776-cdecfa9e1010@foxmail.com>
 <YllN/OmjpYdT1tO9@otcwcpicx3.sc.intel.com>
 <tencent_CD35B6A6FBB48186B38EF641F088BAED1407@qq.com>
 <20220415140002.7c12b0d2@jacob-builder>
From:   "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <df95e2ad-4010-cd9c-094b-8b816419951a@foxmail.com>
Date:   Sat, 16 Apr 2022 09:43:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220415140002.7c12b0d2@jacob-builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/16 上午5:00, Jacob Pan wrote:
> Hi zhangfei.gao@foxmail.com,
>
> On Fri, 15 Apr 2022 19:52:03 +0800, "zhangfei.gao@foxmail.com"
> <zhangfei.gao@foxmail.com> wrote:
>
>>>>> A PASID might be still used even though it is freed on mm exit.
>>>>>
>>>>> process A:
>>>>> 	sva_bind();
>>>>> 	ioasid_alloc() = N; // Get PASID N for the mm
>>>>> 	fork(): // spawn process B
>>>>> 	exit();
>>>>> 	ioasid_free(N);
>>>>>
>>>>> process B:
>>>>> 	device uses PASID N -> failure
>>>>> 	sva_unbind();
>>>>>
>>>>> Dave Hansen suggests to take a refcount on the mm whenever binding the
>>>>> PASID to a device and drop the refcount on unbinding. The mm won't be
>>>>> dropped if the PASID is still bound to it.
>>>>>
>>>>> Fixes: 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID
>>>>> allocation and free it on mm exit")
>>>>>
> Is process A's mm intended to be used by process B? Or you really should
> use PASID N on process B's mm? If the latter, it may work for a while until
> B changes mapping.
>
> It seems you are just extending the life of a defunct mm?

 From nginx code, the master process init resources, then fork daemon 
process to take over,
then master process exit by itself.

src/core/nginx.c
main
ngx_ssl_init(log);    -> openssl engine -> bind_fn -> sva_bind()
ngx_daemon(cycle->log)

src/os/unix/ngx_daemon.c
ngx_daemon(ngx_log_t *log)
{
      int  fd;

      switch (fork()) {
      case -1:
          ngx_log_error(NGX_LOG_EMERG, log, ngx_errno, "fork() failed");
          return NGX_ERROR;

      case 0:
         // the fork daemon process
          break;

      default:
        // master process directly exit, and release mm as well as ioasid
          exit(0);
      }

       // only daemon process

Thanks

>
> Thanks,
>
> Jacob

