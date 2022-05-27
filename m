Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D004535D68
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350575AbiE0J2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350548AbiE0J2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:28:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3773D66AE2
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653643691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SOlTxwJJvUVKxrD2wVdvDhFovGyJP5J2OHX4mkZ+Kc0=;
        b=EISWOmbBju5Chlj73gIWHLhOHOj8vRcgo6TYrL2IL2zor9FDkdXTiyGWFtX3DFW6Cnhf/r
        2dMMDmddv+tstHl/5oowbf7jOZf76hfIlsdwbG+XDpM6y9P3Jt19fLm2QYL9pzMiXCQc7W
        vtXChSZReaQ3KlbKObltyC7IpTx4gnY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-yRXTyIqJOgWE8Eiic0G0ZA-1; Fri, 27 May 2022 05:28:10 -0400
X-MC-Unique: yRXTyIqJOgWE8Eiic0G0ZA-1
Received: by mail-pj1-f70.google.com with SMTP id m5-20020a17090a4d8500b001e0cfe135c7so2537411pjh.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SOlTxwJJvUVKxrD2wVdvDhFovGyJP5J2OHX4mkZ+Kc0=;
        b=fP40OusHMYB6e3gTzB5JcPOx8fvszFIL2QEWL5SpqoYF2WRNnAolMBiOBQQtfeCa1Y
         lpXMXNyzw3ljwp/9hfr4CfqU/PD58jp3EQTq+g6FBYxIBHA+j4OTBaOvpq4tG+OUO5LJ
         oSohZXETQ88Pr1yd6Le4QCJjkszgxrqVwcfEWT4U/XTQL7qihFKeHP34FAH7BfQRTJH9
         S8Fnb4pJLJgVpK64GLjne2vWtI2Q4D+tkhJkj2gWKtSmsxkb8iH8O/YXOdCjJ6C/TP6g
         PtPrfb7nXcJsDjcEVZv4gpN5f54Q/4GBJo+ii6/9o/A8qFT3rIBzxuH1/CNai2i05V7I
         Mb8g==
X-Gm-Message-State: AOAM530481b7n7myfyN3AWGR561E+rptYkJH9dCv0qFXg/xBADlQHgvP
        uAPOQuczVOIwiE3Awb6+uwIAXYvAxZO7NfAlGS+cm0CSMLdh92GNgZingR3mZ40rl7jzYAwpOFW
        z2zXUZ9CfNHU4H4GYVbSKTwNvNIeiSTn71EdT5VzBm66OFP+UGagMDWY0rK2qF9/fQx+A9VBDGA
        ==
X-Received: by 2002:a17:902:748c:b0:163:6c22:8ca0 with SMTP id h12-20020a170902748c00b001636c228ca0mr9332300pll.159.1653643689088;
        Fri, 27 May 2022 02:28:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqMccbNeTb/akIZGXdPSkzZmLiAB5yTAJbv9ot4Ol43Q+helUHoQO1lhAjP9SdmNjmsFpG2g==
X-Received: by 2002:a17:902:748c:b0:163:6c22:8ca0 with SMTP id h12-20020a170902748c00b001636c228ca0mr9332274pll.159.1653643688720;
        Fri, 27 May 2022 02:28:08 -0700 (PDT)
Received: from [10.72.12.81] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id by5-20020a056a00400500b005107a4d5096sm2931200pfb.30.2022.05.27.02.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 02:28:08 -0700 (PDT)
Subject: Re: [RFC PATCH v2] ceph: prevent a client from exceeding the MDS
 maximum xattr size
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Gregory Farnum <gfarnum@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220525172427.3692-1-lhenriques@suse.de>
 <fb3d817d8b6235472e517a9fc9ad0956fb4e8cf2.camel@kernel.org>
 <3cb96552-9747-c6b4-c8d3-81af60e5ae6a@redhat.com>
 <ca4928507bdf329bbe5b32a7b71f4a4295e5bba1.camel@kernel.org>
 <f238e4a1-ef98-ccfe-6345-51b6d9a34319@redhat.com>
 <CAJ4mKGZyw+uKjwkSBseETtKXwJOSV2D8J9mLH-8yB8w98Ow=fA@mail.gmail.com>
 <87leunwd5z.fsf@brahms.olymp>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <852c5941-3ae9-2f37-6742-5801fdb025ed@redhat.com>
Date:   Fri, 27 May 2022 17:28:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87leunwd5z.fsf@brahms.olymp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/27/22 5:14 PM, Luís Henriques wrote:
> Gregory Farnum <gfarnum@redhat.com> writes:
>
>> On Thu, May 26, 2022 at 6:10 PM Xiubo Li <xiubli@redhat.com> wrote:
>>>
>>> On 5/27/22 8:44 AM, Jeff Layton wrote:
>>>> On Fri, 2022-05-27 at 08:36 +0800, Xiubo Li wrote:
>>>>> On 5/27/22 2:39 AM, Jeff Layton wrote:
>>>>>> A question:
>>>>>>
>>>>>> How do the MDS's discover this setting? Do they get it from the mons? If
>>>>>> so, I wonder if there is a way for the clients to query the mon for this
>>>>>> instead of having to extend the MDS protocol?
>>>>> It sounds like what the "max_file_size" does, which will be recorded in
>>>>> the 'mdsmap'.
>>>>>
>>>>> While currently the "max_xattr_pairs_size" is one MDS's option for each
>>>>> daemon and could set different values for each MDS.
>>>>>
>>>>>
>>>> Right, but the MDS's in general don't use local config files. Where are
>>>> these settings stored? Could the client (potentially) query for them?
>>> AFAIK, each process in ceph it will have its own copy of the
>>> "CephContext". I don't know how to query all of them but I know there
>>> have some API such as "rados_conf_set/get" could do similar things.
>>>
>>> Not sure whether will it work in our case.
>>>
>>>> I'm pretty sure the client does fetch and parse the mdsmap. If it's
>>>> there then it could grab the setting for all of the MDS's at mount time
>>>> and settle on the lowest one.
>>>>
>>>> I think a solution like that might be more resilient than having to
>>>> fiddle with feature bits and such...
>>> Yeah, IMO just making this option to be like the "max_file_size" is more
>>> appropriate.
>> Makes sense to me — this is really a property of the filesystem, not a
>> daemon, so it should be propagated through common filesystem state.
> Right now the max_xattr_pairs_size seems to be something that can be set
> on each MDS, so definitely not a filesystem property.  To be honest, I
> think it's nasty to have this knob in the first place because it will
> allow an admin to set it to a value that will allow clients to blowup the
> MDS cluster.
>
>> I guess Luis' https://github.com/ceph/ceph/pull/46357 should be
>> updated to do it that way?
> Just to confirm, by "to do it that way" you mean to move that setting into
> the mdsmap, right?

Yeah, I think so.

-- XIubo

>
>> I see some discussion there about handling
>> old clients which don't recognize these limits as well.
> Yeah, this is where the feature bit came from.  This would allow old
> clients to be identified so that the MDS would not give them 'Xx'
> capabilities.  Old clients would be able to set xattrs but not to buffer
> them, i.e. they'd be forced to do the SETXATTR synchronously.
>
> Cheers,

