Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CE35600AD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbiF2NBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbiF2NBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:01:07 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83B43981E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 06:01:04 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o16so22397382wra.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 06:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zixMObpfulGTwAoltwFkjMEiXnzniB8j4U71iV0YG90=;
        b=dxyoDxWAzCqTU8OCmeiMKs5Pttjd1lhQCfvTCiKjDvJOxZx0TIi6lhr1eWUx20cNTI
         f6feSOgwBE6WwU55ZVVvaou+CLXp8kEoD/ZrmkIw252cPJJiTR90ZpB5kzwc6MTYtXZc
         lp0IybDb1jOhRUu6MRyKILVp6JdH2i70HJnTpAtvBQR+3aj1A72TktcQfiwAvwIuIGc1
         QI/a2qxcLHMQdPEQfmNCdWw0/uwyxCwWa43rzNr/nPzK8GkOntXKhZF4cMiM85AEB5j5
         JXBWvPboK3VlZUTXQh/noBSyIPafELwL8D9pjIXDnd/hkkhslyNlS3/Rtnp24lFRje9O
         3Y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zixMObpfulGTwAoltwFkjMEiXnzniB8j4U71iV0YG90=;
        b=26B06JazPkxoW/NauJhtDIs/QNhxr4YB5iw56mknrswI4KE27y1mRoW9+HkH+4Lzvg
         Wr9UdNg0IeeBGy/WE0qbkQjSEWZH7O6cTGNU1VoxZuREE2iJ+JRtQp1v/hXS7E4lTYNO
         50usGT+7QKB49kT6ynDQlww60o/iOqe99iEVMlsQCeh71jgZAd1bSWZJ42X2a+e/dc80
         lVyrviqGDYqcwBjSHzPBESs55cQiZ7pLKzmXGOFh/PTT2Jxh6W4rJSVsdkRH481il5No
         mopO2TB2djF7a3jlywVZ+k7TqS2nxU4YW//iIocF41z9+Y3mFNXcuQ1Xv6/B4d9FVgTj
         Vmbw==
X-Gm-Message-State: AJIora+plaiyhUPNFJVENaAa7md4nZKYUmW2hrk146aVE2Q25u+i+L4S
        2lIbeMZMMc0QoTOqboMl9QwCIQ==
X-Google-Smtp-Source: AGRyM1t8EzixgcxNWBwR61U9RreYjnfGAdih3/VSMMog6DY3jLeW3MG6NHaOoiHYsRu4Nc9q4db4Tg==
X-Received: by 2002:a5d:4647:0:b0:21b:bde9:f267 with SMTP id j7-20020a5d4647000000b0021bbde9f267mr2995355wrs.526.1656507662120;
        Wed, 29 Jun 2022 06:01:02 -0700 (PDT)
Received: from smtpclient.apple ([90.242.255.206])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c501e00b0039c454067ddsm3204954wmr.15.2022.06.29.06.01.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jun 2022 06:01:01 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: fwnode_for_each_child_node() and OF backend discrepancy
From:   Grant Likely <grant.likely@linaro.org>
In-Reply-To: <CAJZ5v0g1VqJ2_2MtKGv-sHmKVQ12Rmj9r3Lr6D9wjmUYJwtoCw@mail.gmail.com>
Date:   Wed, 29 Jun 2022 14:01:00 +0100
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Saravana Kannan <saravanak@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <30D246E1-B0C7-404A-B690-A894AA79A524@linaro.org>
References: <4e1d5db9dea68d82c94336a1d6aac404@walle.cc>
 <b8ec04dc-f803-ee2c-29b7-b0311eb8c5fb@linaro.org>
 <CAJZ5v0jz=ee5TrvYs0_ovWn9sT06bcKDucmmocD8L-d9ZZ5DzQ@mail.gmail.com>
 <0b8e357d-1d8b-843f-d8b6-72c760bcd6fb@linaro.org>
 <CAJZ5v0g1VqJ2_2MtKGv-sHmKVQ12Rmj9r3Lr6D9wjmUYJwtoCw@mail.gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 29 Jun 2022, at 11:50, Rafael J. Wysocki <rafael@kernel.org> wrote:
>=20
> On Tue, Jun 28, 2022 at 12:32 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>=20
>> On 27/06/2022 15:33, Rafael J. Wysocki wrote:
>>> On Mon, Jun 27, 2022 at 3:08 PM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>=20
>>>> On 27/06/2022 14:49, Michael Walle wrote:
>>>>> Hi,
>>>>>=20
>>>>> I tired to iterate over all child nodes, regardless if they are
>>>>> available
>>>>> or not. Now there is that handy fwnode_for_each_child_node() (and =
the
>>>>> fwnode_for_each_available_child_node()). The only thing is the OF
>>>>> backend
>>>>> already skips disabled nodes [1], making =
fwnode_for_each_child_node()
>>>>> and
>>>>> fwnode_for_each_available_child_node() behave the same with the OF
>>>>> backend.
>>>>>=20
>>>>> Doesn't seem to be noticed by anyone for now. I'm not sure how to =
fix
>>>>> that
>>>>> one. fwnode_for_each_child_node() and also =
fwnode_get_next_child_node()
>>>>> are
>>>>> used by a handful of drivers. I've looked at some, but couldn't =
decide
>>>>> whether they really want to iterate over all child nodes or just =
the
>>>>> enabled
>>>>> ones.
>>>>=20
>>>> If I get it correctly, this was introduced  by 8a0662d9ed29 =
("Driver
>>>> core: Unified interface for firmware node properties")
>>>> .
>>>=20
>>> Originally it was, but then it has been reworked a few times.
>>>=20
>>> The backend callbacks were introduced by Sakari, in particular.
>>=20
>> I see you as an author of 8a0662d9ed29 which adds
>> device_get_next_child_node() and uses of_get_next_available_child()
>> instead of of_get_next_child(). Although it was back in 2014, so =
maybe
>> it will be tricky to get original intention. :)
>=20
> The OF part of this was based on Grant's suggestions.  My
> understanding at that time was that this was the right thing to do for
> OF and nobody told me otherwise.
>=20
>> Which commit do you mean when you refer to Sakari's work?
>=20
> 3708184afc77 device property: Move FW type specific functionality to
> FW specific files
>=20
> However, it didn't change the "available" vs "any" behavior for OF.

Back in the mists of time indeed. I don=E2=80=99t remember anything =
specific about all/available variants of the fwnode_ helpers. Auditing =
the existing users is probably needed to decide whether or not it can be =
changed.

g.

>=20
>>>=20
>>>> The question to Rafael - what was your intention when you added
>>>> device_get_next_child_node() looking only for available nodes?
>>>=20
>>> That depends on the backend.
>>=20
>> We talk about OF backend. In your commit device_get_next_child_node =
for
>> OF uses explicitly available node, not any node.
>=20
> Yes, it does.
>=20
> If that doesn't match the cases in which it is used, I guess it can be =
adjusted.
>=20
>>> fwnode_for_each_available_child_node() is more specific and IIRC it
>>> was introduced for fw_devlink (CC Saravana).
>>>=20
>>>> My understanding is that this implementation should be consistent =
with
>>>> OF implementation, so fwnode_get_next_child_node=3Dget any child.
>>>=20
>>> IIUC, the OF implementation is not consistent with the
>>> fwnode_get_next_child_node=3Dget any child thing.
>>>=20
>>>> However maybe ACPI treats it somehow differently?
>>>=20
>>> acpi_get_next_subnode() simply returns the next subnode it can find.
>=20
> I guess that the confusion is related to what "available" means for =
ACPI and OF.
>=20
> In the ACPI case it means "this a device object corresponding to a
> device that is present".  In OF it is related to the "status" property
> AFAICS.

