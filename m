Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3181054C721
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345260AbiFOLEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345158AbiFOLEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:04:43 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6EF5401D;
        Wed, 15 Jun 2022 04:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655291056; x=1686827056;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BikRfTtyNSP6EN+fSel6ObjJyNkgPpPQ+YreNW/Ar5k=;
  b=BGR4ssMjZlScEOQC36jMEl3MC4jQkj+BHadR3L7CIgIhWbMRGRIKBmLw
   XYFtSdGKBRyc4O8giZn15cA/Jkp2irWwepU9usYfgqVBv1l1N/DLkyjNh
   t7MJrhn3VLr39Jy6zUZJfhYRLc4dQaDgLPi6L7x3iT/AfVrtsyTPDsl+d
   g=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Jun 2022 04:04:16 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 04:04:16 -0700
Received: from [10.50.37.107] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 15 Jun
 2022 04:04:12 -0700
Message-ID: <39a16f7b-ef12-4cb2-b8fd-d79b8fdf9ebe@quicinc.com>
Date:   Wed, 15 Jun 2022 16:34:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Commit 282d8998e997 (srcu: Prevent expedited GPs and blocking
 readers from consuming CPU) cause qemu boot slow
Content-Language: en-US
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
        <paulmck@kernel.org>, zhangfei <zhangfei.gao@linaro.org>
CC:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>,
        Auger Eric <eric.auger@redhat.com>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>
References: <tencent_E306F58EAEC1D188ED6D5F358A269F34C707@qq.com>
 <20220613035711.GY1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220613041652.GA3976000@paulmck-ThinkPad-P17-Gen-1>
 <tencent_F82250B6E3D51A9AC0D2BE1AE43A4E060909@qq.com>
 <20220613121831.GA1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_65C7D0A04984EDB6A79A5E5379DA7E835206@qq.com>
 <20220613145900.GC1790663@paulmck-ThinkPad-P17-Gen-1>
 <7b6c983b21d44119b61716a66de397ed@huawei.com>
 <f9684a69-5467-a440-abd1-7cf5ad3a81f7@quicinc.com>
 <tencent_8FD344DA7FC376C7D1204604DA7689DA4906@qq.com>
 <20220614141712.GR1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_DFF5A6C9352C76C00C7E46E06F2BA945350A@qq.com>
 <042142db-aab2-fc4a-c1a5-371223c80440@quicinc.com>
 <7f6d9360-9254-88d6-fb34-13f248d2e542@redhat.com>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <7f6d9360-9254-88d6-fb34-13f248d2e542@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/2022 4:20 PM, Paolo Bonzini wrote:
> On 6/15/22 12:40, Neeraj Upadhyay wrote:
>>
>> This is useful data, thanks! Did you get chance to check between 100 
>> and 1000, to narrow down further, from which point (does need to be 
>> exact value) between 100 and 1000,  you start seeing degradation at, 
>> for ex. 250, 500 , ...?
>>
>> Is it also possible to try experiment 10 and 11 with below diff.
>> What I have done in below diff is, call srcu_get_delay() only once
>> in try_check_zero() (and not for every loop iteration); also
>> retry with a different delay for the extra iteration which is done
>> when srcu_get_delay(ssp) returns 0.
>>
>> Once we have this data, can you also try by changing 
>> SRCU_RETRY_CHECK_LONG_DELAY   to 100, on top of below diff.
>>
>> #define SRCU_RETRY_CHECK_LONG_DELAY  100
> 
> Is there any data that you would like me to gather from the KVM side, 
> for example with respect to how much it takes to do synchronize_srcu() 
> on an unpatched kernel, or the duration of the read-sides?
> 

Hi Paolo,

Thanks! I think synchronize_srcu() time and read side duration will 
help. Given that changing SRCU_MAX_NODELAY_PHASE value has impact
on the boot time (and SRCU_MAX_NODELAY_PHASE impact is dependent on 
duration of SRCU read side duration), this information will be helpful 
to get more understanding of the scenario.


Thanks
Neeraj

> Thanks,
> 
> Paolo
> 
