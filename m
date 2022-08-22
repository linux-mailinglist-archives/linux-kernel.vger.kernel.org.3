Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3187059BDF3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 12:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiHVKyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 06:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbiHVKyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 06:54:06 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B972510570
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 03:54:04 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id Q54Do2dalkifIQ54Do40A4; Mon, 22 Aug 2022 12:54:02 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 22 Aug 2022 12:54:02 +0200
X-ME-IP: 90.11.190.129
Message-ID: <23fbee0f-4d9c-344f-9fb4-f9cc77f38ed3@wanadoo.fr>
Date:   Mon, 22 Aug 2022 12:54:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] media: dw100: Fix an error handling path in dw100_probe()
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Xavier Roumegue <xavier.roumegue@oss.nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-media@vger.kernel.org
References: <7213b90d0d872be154cff81aec1ad8a4a77116af.1661161223.git.christophe.jaillet@wanadoo.fr>
 <YwNS5jr2+ersua9B@pendragon.ideasonboard.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <YwNS5jr2+ersua9B@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 22/08/2022 à 11:56, Laurent Pinchart a écrit :
> Hi Christophe,
> 
> Thank you for the patch.
> 
> On Mon, Aug 22, 2022 at 11:40:43AM +0200, Christophe JAILLET wrote:
>> After a successful call to media_device_init() it is safer to call
>> media_device_init().
> 
> I assume you meant media_device_cleanup() ? With this fixed,

+1.
I assume that it can be fixed when applied (otherwise tell me and I'll 
send a v2).

CJ

> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
>> Add the missing call in the error handling path of the probe, as already
>> done in the remove function.
>>
>> Fixes: bd090d4d995a ("media: dw100: Add i.MX8MP dw100 dewarper driver")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/media/platform/nxp/dw100/dw100.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/media/platform/nxp/dw100/dw100.c b/drivers/media/platform/nxp/dw100/dw100.c
>> index 94518f0e486b..b3b057798ab6 100644
>> --- a/drivers/media/platform/nxp/dw100/dw100.c
>> +++ b/drivers/media/platform/nxp/dw100/dw100.c
>> @@ -1623,6 +1623,7 @@ static int dw100_probe(struct platform_device *pdev)
>>   error_v4l2:
>>   	video_unregister_device(vfd);
>>   err_m2m:
>> +	media_device_cleanup(&dw_dev->mdev);
>>   	v4l2_m2m_release(dw_dev->m2m_dev);
>>   err_v4l2:
>>   	v4l2_device_unregister(&dw_dev->v4l2_dev);
> 

