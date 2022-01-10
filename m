Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F3948951B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242775AbiAJJVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:21:31 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:35082
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242733AbiAJJV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:21:28 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2081E40710
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 09:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641806486;
        bh=+nJaduhPmVzgxWjNKs+nFWjH5kVSJ3Nlk+J2KS381O0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=CIpeGV7pvbKME6OgLRczGvG1luKaRhZrytpJZV79q5nJPiMkH2D/q57wLIpEKa3k/
         QAMx914OJZBwNPGpRKPnKd5Rr0rMFWDOWcjjcIGarCweWO9JMWNWtbI7j7lN/AqvNS
         2aRiOHeNLJmZWza3lNpbdMkGM01o6Y1PjLoS/3oeFRX5TYMgUB19/JtyaX0spPBJBA
         mEx4lasLaDihSrQljpMTXgIVFsLfwbrCmmoWJzBYw3cibvgsRArVVBr6huFKFtVFU/
         fjL0ZEbaY0FXItmZHtjYzXfk4Ol1R7XMEkRUe9f7Vp+eGSDCr/jqH4afCd1+dS77jX
         DgwSwI0KTWWHw==
Received: by mail-ed1-f71.google.com with SMTP id c8-20020a05640227c800b003fdc1684cdeso1570046ede.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+nJaduhPmVzgxWjNKs+nFWjH5kVSJ3Nlk+J2KS381O0=;
        b=u7NKL27ELIPKtuI1Dbv4QFSMQBSojN/TqJL90FyttW+Br2Tm6Fv39IGKt9kJFw3mPR
         GFC7IXB733I8aXDLgMtElQwPgm5Rnk1PI81/USGpj6MjjVnMMG/iZTr4yfDDX5kovU5C
         Dgznhz1um6b5ACsBbTTv0SQtCGXLKMngaPlO/XcMsaN8oTGLaD2YggN9ppXAWzq1ZXvU
         0uxqnEzarO2S184n0HxXqGleNBEhXaCCLJcS2zj+URrl0Z/veX9BA9z/wcc7aGTNG2ty
         gXmIr6v1pqNAkShZKKMbA3b3lOAC8xK+oVEmhekePN2Jf/SJtPTbnHb/7z42Y40F8Wyq
         rMig==
X-Gm-Message-State: AOAM532f76a8SQKE5qAfzIbnLX8KaRDhC+fIqojDima2u53LUxdieZzf
        V0DX59chw7NcDaynESqKZ4G/RtiFKE3h1nDnNtuFn+DAH7Cs4znZ95jfxfrwaaI29icRUg7B2av
        WJx+bJ9sCxLnk+fb5LF5/nVPrZBmxveWMvzbVL/Zp/Q==
X-Received: by 2002:a50:cc07:: with SMTP id m7mr71953598edi.4.1641806485812;
        Mon, 10 Jan 2022 01:21:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmEmnXL1pZn58kxnt+WXeidMJmzjqQOx68VtLwlRjQqmdUwMASOr7ymat7HHWFkjneIavIrQ==
X-Received: by 2002:a50:cc07:: with SMTP id m7mr71953588edi.4.1641806485641;
        Mon, 10 Jan 2022 01:21:25 -0800 (PST)
Received: from [192.168.1.126] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id 17sm1865199ejo.27.2022.01.10.01.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 01:21:25 -0800 (PST)
Message-ID: <2ee68b52-bb73-e013-d722-0c033391b704@canonical.com>
Date:   Mon, 10 Jan 2022 10:21:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 0/7] arm/arm64: dts: Remove unused num-viewport from pcie
 node
Content-Language: en-US
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     jszhang@kernel.org, shawnguo@kernel.org, leoyang.li@nxp.com,
        robh+dt@kernel.org, linux@armlinux.org.uk, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, hayashi.kunihiko@socionext.com,
        mhiramat@kernel.org, nobuhiro1.iwamatsu@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20211229160245.1338-1-jszhang@kernel.org>
 <d3cb7b8439ee3d06@bloch.sibelius.xs4all.nl>
 <99115cc4-32f6-d217-68be-33256a6993a8@canonical.com>
 <d3cb933f371ab5b5@bloch.sibelius.xs4all.nl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <d3cb933f371ab5b5@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2022 20:39, Mark Kettenis wrote:
>> Date: Fri, 7 Jan 2022 13:47:03 +0100
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>
>> On 29/12/2021 17:50, Mark Kettenis wrote:
>>>> From: Jisheng Zhang <jszhang@kernel.org>
>>>> Date: Thu, 30 Dec 2021 00:02:38 +0800
>>>>
>>>> After commit 281f1f99cf3a("PCI: dwc: Detect number of iATU windows"),
>>>> the number of iATU windows is detected at runtime, what's more,
>>>> the 'num-viewport' property parsing has been removed, so remove the
>>>> unused num-viewport from pcie node(s).
>>>>
>>>> It's too late for linux-5.17-rc1, I will rebase and send out v2 if
>>>> necessary when 5.17-rc1 is released.
>>>
>>> Please no.  This only makes the device trees unnecessarily
>>> incompatible with older kernels
>>
>> Anyone who is running a new DTB with older kernel is doomed anyway, not
>> only because of this change but hundreds of other similar cleanups, e.g.
>> making DTS conforming to dtschema. Are you sure there are such use cases
>> of using new DTB with old kernel? I cannot imagine making a stable
>> product with such scenario...
> 
> Well, many of those changes just affect the node names, which aren't
> part of the ABI.  And adding missing properties or compatibles doesn't
> break things either.  But yes, we keep seeing diffs to "cleanup"
> bindings and device trees, especially in the context of converting
> them to dtschema.  And that's just wrong.  If old device trees don't
> pass validation, the default assumption should be that the schema is
> wrong; not the other way around.

I cannot get how you reached a conclusion that old device tree could be
good, but old bindings would be bad... Both were developed without
consistency, sometimes without proper review. Simply both can be wrong
and now we fix them - the bindings by converting to stricter schema and
DTS files by aligning them with new schema.

There was never a contract between us and users that OLD kernel will
work with NEW DTB. The only contract we made was the other way around -
NEW kernel will work with OLD DTB.

I understand that it is useful to have new DTB working with old kernel.
I consider it as a "nice to have" feature but:
1. Still there are no real users of such pattern (new DTB with old
kernel), around Linux kernel. If they are - I am repaeting - their Linux
project is already broken.

2. If Linux drivers or other projects depend on node names and anything
not being part of bindings (the ABI), they are broken by design. They
should either be fixed or accept that might get broken anytime soon
because they do not use bindings but undocumented parts (which are not ABI).

3. "Nice to have" should not stop us in improving out codebase and
making it easier to maintain for us. We do not make these "dtschema
align" changes for pure fun, but to make everything easier for us in the
longterm. The dtschema checks I was running (and converting to dtschema)
already found errors in DTS. These are real bugs which are fixed by this
stricter dtschema.

Best regards,
Krzysztof
