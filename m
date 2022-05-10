Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10EF521C75
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344014AbiEJOhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344251AbiEJOdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:33:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B76222F1F0C
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652190672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZAGHGrcoAkfJTCYhh0+KXJWKuk5hs3gPSub8G/kTM/Y=;
        b=IH+aUakekotAcKpeQOsJUPnOvHDMTpsGCN9srw7t2FI7l3a+RjlK46n4Ry0ACh2lByZDWa
        YH/a5JiTcpMz45JAR1l3HS5RxiBY3MsETQWHhY1Zi/AabHK3OB2TCRLp6W9WG0rIN10PbY
        UKdtgSgqzF4cwLh8BuotmsmWuTQzwi4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-RDi7atB5Mt2bknTqYPGSXg-1; Tue, 10 May 2022 09:51:11 -0400
X-MC-Unique: RDi7atB5Mt2bknTqYPGSXg-1
Received: by mail-wm1-f71.google.com with SMTP id m124-20020a1c2682000000b00393fcd2722dso834711wmm.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZAGHGrcoAkfJTCYhh0+KXJWKuk5hs3gPSub8G/kTM/Y=;
        b=uMWloU2sqFOP0eCig8KcqZ2kaWZNO4dJD1rnE3O61DzkaR+6aWsBNCMfPdwdUVAH8E
         ZfLcZ8g3tNuO6+DRmaAzQzFUfqR619lwC+GWGhj1pm6U0wWZrAzEcKsr/ZtrNtkFHJN6
         OFWq+xuBPg4shs2CINzrhcSya+MsLkLKiB5bDndAyIQU8tpJZQx8rqyKxmccB834/Vc2
         ktrkg7gCIaoxSIH5n8CHNi+7bW0MB/JXyfzq8iphwcmvZjQRG7rtshaqyezyEGGuJruo
         JdXyGX0100VMv7YXeUnkArqDG6+sNixV30l0jgHNUy7JVhl+BFAtGNRev/G1cHRalSSw
         622w==
X-Gm-Message-State: AOAM5333L1iAWsaATFTOu95f1utoMZI/0aMRiyBm/IVaXsMComir5FE2
        e1bOhhRfhXj/Fhkpgo8X+Lx4FnrF9ef5kh8BU8yMMx/pAJZKM75+19Bf5luRJ/0lOK+LyT7KxdQ
        DfrzUBYAHr41QpszaDMXvnLTI
X-Received: by 2002:a05:6000:1a89:b0:20c:613f:da94 with SMTP id f9-20020a0560001a8900b0020c613fda94mr18362133wry.356.1652190667155;
        Tue, 10 May 2022 06:51:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3IgxLwZziy91sXD3yrkheTJ3uGwJ3zLdE2j03c0MRWxjGcQGeDy06Ef/vxojp3Um9k3+OMg==
X-Received: by 2002:a05:6000:1a89:b0:20c:613f:da94 with SMTP id f9-20020a0560001a8900b0020c613fda94mr18362122wry.356.1652190666957;
        Tue, 10 May 2022 06:51:06 -0700 (PDT)
Received: from ?IPV6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.googlemail.com with ESMTPSA id l7-20020a5d5607000000b0020c5253d904sm13941681wrv.80.2022.05.10.06.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 06:51:06 -0700 (PDT)
Message-ID: <8f24d358-1fbd-4598-1f2d-959b4f8d75fd@redhat.com>
Date:   Tue, 10 May 2022 15:50:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [syzbot] INFO: task hung in synchronize_rcu (3)
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        syzbot <syzbot+0c6da80218456f1edc36@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, davem@davemloft.net, jhs@mojatatu.com,
        jiri@resnulli.us, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@elte.hu, mlevitsk@redhat.com, netdev@vger.kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vinicius.gomes@intel.com,
        viro@zeniv.linux.org.uk, xiyou.wangcong@gmail.com
References: <000000000000402c5305ab0bd2a2@google.com>
 <0000000000004f3c0d05dea46dac@google.com> <Ynpsc7dRs8tZugpl@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Ynpsc7dRs8tZugpl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 15:45, Sean Christopherson wrote:
>>
>>      KVM: x86: Don't re-acquire SRCU lock in complete_emulated_io()
>>
>> bisection log:https://syzkaller.appspot.com/x/bisect.txt?x=16dc2e49f00000
>> start commit:   ea4424be1688 Merge tag 'mtd/fixes-for-5.17-rc8' of git://g..
>> git tree:       upstream
>> kernel config:https://syzkaller.appspot.com/x/.config?x=442f8ac61e60a75e
>> dashboard link:https://syzkaller.appspot.com/bug?extid=0c6da80218456f1edc36
>> syz repro:https://syzkaller.appspot.com/x/repro.syz?x=1685af9e700000
>> C reproducer:https://syzkaller.appspot.com/x/repro.c?x=11b09df1700000
>>
>> If the result looks correct, please mark the issue as fixed by replying with:
>>
>> #syz fix: KVM: x86: Don't re-acquire SRCU lock in complete_emulated_io()
>>
>> For information about bisection process see:https://goo.gl/tpsmEJ#bisection
> #syz fix: KVM: x86: Don't re-acquire SRCU lock in complete_emulated_io()
> 

Are you sure? The hang is in synchronize_*rcu* and the testcase is 
unrelated to KVM.  It seems like the testcase is not 100% reproducible.

Paolo

