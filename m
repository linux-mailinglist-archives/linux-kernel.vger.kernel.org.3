Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385274D391E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbiCISsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbiCISsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:48:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 986C21A39C1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 10:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646851638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v3nc17BUtz+qPmTypFBvwUPQaSTBnMDANsUTpV88wwo=;
        b=XdOxSVZTHvYZUZUlFlXKn8DlyTdx+x6xBvzCEYcuiOoUEcmChfiR3KguqqapJ7A7bNSCni
        caBa08he3GiV0eab7lBby3oXpd/e9UzKuqZ/VyKHslO6sckXpwLYBaWuR4prBZf/1CCFSl
        9W8c2xWJ1h5ed+sTa3oFYOpuJXOkLzE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-SmPA6lSgNtuPrLh9_cijCg-1; Wed, 09 Mar 2022 13:47:17 -0500
X-MC-Unique: SmPA6lSgNtuPrLh9_cijCg-1
Received: by mail-wm1-f72.google.com with SMTP id h206-20020a1c21d7000000b003552c13626cso2953640wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 10:47:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v3nc17BUtz+qPmTypFBvwUPQaSTBnMDANsUTpV88wwo=;
        b=tnBMgby1IWthqN75myEpcDFhbziAyNHbDBiSjF2rUmC4b5hKaYQGqu43eYcveuVQ2B
         7YqkhVOtrhGGux5C1e3XMgFpHZeCfzptBIOVoMARIi2rxae+u2T/WtyugSEWLwXdx6Es
         HZ5Lt0ZzjDpQFwaHCoWtBXP3SDTgFGXakxD+t26aDa2kkZqrHocoM7KbhuMYItMigdNY
         8lIy0/xLx9CPdFZtD4Ji49B0QQNFaPNlf5ghQF8Me3BuEtFVZdOO51zVgu6hk3epNw2T
         FbB8muejtoQzZ+n1iXTcYn3E6dzI7ioZQtxL515svrjklBMsdlagaMifmoLA8pD8PEJ3
         /0WA==
X-Gm-Message-State: AOAM5314dIm7clH81tfBGzJBoFNC7izDgutxRFgL53yyChAM7WP18Og0
        yLgXZUiofmryheBABXHM7NZE4n2h9Oo5lJWTcfOW4QJN4W0CPB+3D8EejZ/mg51BZaZrnS4orcp
        s4c+wXvjA3SDz4Qy3G1pnGuW1
X-Received: by 2002:a05:6000:1a52:b0:1f0:2d62:2bbb with SMTP id t18-20020a0560001a5200b001f02d622bbbmr769999wry.614.1646851635727;
        Wed, 09 Mar 2022 10:47:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw9OJCzl0unpcmM0QiwDwLYC4TXVttgEnD6Q8PEWAqXMM5Vs4LdirN5xhBqiLXAVn8NCdOCSA==
X-Received: by 2002:a05:6000:1a52:b0:1f0:2d62:2bbb with SMTP id t18-20020a0560001a5200b001f02d622bbbmr769967wry.614.1646851635462;
        Wed, 09 Mar 2022 10:47:15 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id n17-20020a05600c3b9100b00389d6331f93sm989468wms.3.2022.03.09.10.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 10:47:14 -0800 (PST)
Message-ID: <6a7f13d1-ed00-b4a6-c39b-dd8ba189d639@redhat.com>
Date:   Wed, 9 Mar 2022 19:47:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 4/7] KVM: x86: nSVM: support PAUSE filter threshold and
 count when cpu_pm=on
Content-Language: en-US
To:     Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>
References: <20220301143650.143749-1-mlevitsk@redhat.com>
 <20220301143650.143749-5-mlevitsk@redhat.com>
 <CALMp9eRjY6sX0OEBeYw4RsQKSjKvXKWOqRe=GVoQnmjy6D8deg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CALMp9eRjY6sX0OEBeYw4RsQKSjKvXKWOqRe=GVoQnmjy6D8deg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/22 19:35, Jim Mattson wrote:
> I didn't think pause filtering was virtualizable, since the value of
> the internal counter isn't exposed on VM-exit.
> 
> On bare metal, for instance, assuming the hypervisor doesn't intercept
> CPUID, the following code would quickly trigger a PAUSE #VMEXIT with
> the filter count set to 2.
> 
> 1:
> pause
> cpuid
> jmp 1
> 
> Since L0 intercepts CPUID, however, L2 will exit to L0 on each loop
> iteration, and when L0 resumes L2, the internal counter will be set to
> 2 again. L1 will never see a PAUSE #VMEXIT.
> 
> How do you handle this?
> 

I would expect that the same would happen on an SMI or a host interrupt.

	1:
	pause
	outl al, 0xb2
	jmp 1

In general a PAUSE vmexit will mostly benefit the VM that is pausing, so 
having a partial implementation would be better than disabling it 
altogether.

Paolo

