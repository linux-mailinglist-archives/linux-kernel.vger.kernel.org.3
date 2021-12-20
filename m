Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99CD47A913
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhLTLyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:54:38 -0500
Received: from foss.arm.com ([217.140.110.172]:53058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231644AbhLTLyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:54:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 810CB1042;
        Mon, 20 Dec 2021 03:54:37 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B62823F718;
        Mon, 20 Dec 2021 03:54:35 -0800 (PST)
Message-ID: <320d0e55-0202-a7cf-a021-f9a49e0e2f66@arm.com>
Date:   Mon, 20 Dec 2021 11:54:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] mfd: rk808: add reboot support to rk808.c
Content-Language: en-GB
To:     Peter Geis <pgwipeout@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211217145544.341617-1-pgwipeout@gmail.com>
 <2bebe0ae-27df-f75d-97d6-2e4d2dd032b0@gmail.com>
 <CAMdYzYq=2G1bvu9M_DR0vdQDtcvVBhQFRPTNKo1ySFrMZOk=jg@mail.gmail.com>
 <4d24cb08-0475-3a9d-1b73-24e465f34701@gmail.com>
 <CAMdYzYrDp5zcRJ=TudtiAtviJVMyNmqB5TMNYZ=XN+mb3paSTQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAMdYzYrDp5zcRJ=TudtiAtviJVMyNmqB5TMNYZ=XN+mb3paSTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-17 18:42, Peter Geis wrote:
> On Fri, Dec 17, 2021 at 1:30 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 17.12.2021 21:16, Peter Geis пишет:
>>>>> +                     break;
>>>>> +             default:
>>>>> +                     dev_info(&client->dev, "pmic controlled board reset not supported\n");
>>
>> I'd change this dev_info to dev_dbg to not clutter KMSG.
> 
> I'd prefer to leave this as info, since the device is designated as
> the system power controller but it is only capable of powering down
> the system, not rebooting it.
> But on second thought, anyone who's making these changes would be
> investigating the driver anyway.
> So I'll change it to dev_dbg.

Indeed, this is the expected case for RK808, which has to be 
system-power-controller if you want shutdown to actually power off.

Cheers,
Robin.
