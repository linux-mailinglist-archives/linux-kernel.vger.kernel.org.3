Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEB956A0EE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 13:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbiGGLMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 07:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbiGGLMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 07:12:52 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C0AD32EDF;
        Thu,  7 Jul 2022 04:12:50 -0700 (PDT)
Received: from [10.180.13.185] (unknown [10.180.13.185])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxaeCxv8ZiOf0OAA--.37662S3;
        Thu, 07 Jul 2022 19:12:49 +0800 (CST)
Subject: Re: [PATCH] MIPS: fix pmd_mkinvalid
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1657181495-33004-1-git-send-email-zhanghongchen@loongson.cn>
 <20220707092206.GA9894@alpha.franken.de>
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <bfb97f6b-7a39-8253-bc14-08f2f54ed312@loongson.cn>
Date:   Thu, 7 Jul 2022 19:12:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220707092206.GA9894@alpha.franken.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxaeCxv8ZiOf0OAA--.37662S3
X-Coremail-Antispam: 1UD129KBjvdXoWruw43Aw4kXF1kGF1UWry8Xwb_yoWDtwc_uF
        s2kr4rGw1DZa1rKFWUKw47ZrySkrZrJrW8X34kWrsF9FWkWan5Ar4qg3sFg3WkCws5JFyU
        CF98uFy2qryI9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbx8YjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z2
        80aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
        zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx
        8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc2xS
        Y4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07bOoG
        dUUUUU=
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/7 下午5:22, Thomas Bogendoerfer wrote:
> On Thu, Jul 07, 2022 at 04:11:35PM +0800, Hongchen Zhang wrote:
>> When a pmd entry is invalidated by pmd_mkinvalid,pmd_present should
>> return true.
>> So introduce a _PMD_PRESENT_INVALID_SHIFT bit to check if a pmd is
>> present but invalidated by pmd_mkinvalid.
> 
> What problem are you trying to fix ? What are the symptoms ?
> 
>> Reported-by: kernel test robot <lkp@intel.com>
> 
> the test robot showed problems with your last version of the patch,
> which hasn't been integrated into at least the MIPS tree, so no
> need to that.
> 
> Thomas.
> 

Hi Thomas,
   The idea come from the commit:
   b65399f6111b(arm64/mm: Change THP helpers to comply with generic MM 
  semantics).
   There is an problem now:
	    CPU 0		CPU 1
	pmdp_invalidate		do_page_fault		
	...			  __handle_mm_fault
				    is_swap_pmd == true
				    trigger VM_BUG_ON() ?
	set_pmd_at
   the reason is that pmd_present return true,after this commit
   pmd_present will return false,and the VM_BUG_ON will not be triggered.
   Like arm64 does,we can introduce a new bit to fix this.

Thanks.

