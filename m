Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398CF472A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbhLMKqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbhLMKqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:46:05 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1A7C061574;
        Mon, 13 Dec 2021 02:46:04 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5E519419BC;
        Mon, 13 Dec 2021 10:45:59 +0000 (UTC)
Subject: Re: [PATCH v3 1/3] of: Move simple-framebuffer device handling from
 simplefb to of
To:     Javier Martinez Canillas <javier@dowhile0.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <20211212062407.138309-1-marcan@marcan.st>
 <20211212062407.138309-2-marcan@marcan.st>
 <CABxcv=m4fu8h=FwY7R=thuvd13_ZbFqB9rNNN07QOAd__jdYSQ@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <63334964-d63d-7625-e46f-a6e6ec19e908@marcan.st>
Date:   Mon, 13 Dec 2021 19:45:56 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABxcv=m4fu8h=FwY7R=thuvd13_ZbFqB9rNNN07QOAd__jdYSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2021 17.44, Javier Martinez Canillas wrote:
> Hello Hector,
> 
> On Sun, Dec 12, 2021 at 7:24 AM Hector Martin <marcan@marcan.st> wrote:
>>
>> This code is required for both simplefb and simpledrm, so let's move it
>> into the OF core instead of having it as an ad-hoc initcall in the
>> drivers.
>>
>> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> ---
>>   drivers/of/platform.c          |  4 ++++
>>   drivers/video/fbdev/simplefb.c | 21 +--------------------
>>   2 files changed, 5 insertions(+), 20 deletions(-)
>>
> 
> This is indeed a much better approach than what I suggested. I just
> have one comment.
> 
>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>> index b3faf89744aa..793350028906 100644
>> --- a/drivers/of/platform.c
>> +++ b/drivers/of/platform.c
>> @@ -540,6 +540,10 @@ static int __init of_platform_default_populate_init(void)
>>                  of_node_put(node);
>>          }
>>
>> +       node = of_get_compatible_child(of_chosen, "simple-framebuffer");
> 
> You have to check if the node variable is NULL here.
> 
>> +       of_platform_device_create(node, NULL, NULL);
> 
> Otherwise this could lead to a NULL pointer dereference if debug
> output is enabled (the node->full_name is printed).

Where is it printed? I thought I might need a NULL check, but this code 
was suggested verbatim by Rob in v2 without the NULL check and digging 
through I found that the NULL codepath is safe.

of_platform_device_create calls of_platform_device_create_pdata 
directly, and:

static struct platform_device *of_platform_device_create_pdata(
                                         struct device_node *np,
                                         const char *bus_id,
                                         void *platform_data,
                                         struct device *parent)
{
         struct platform_device *dev;

         if (!of_device_is_available(np) ||
             of_node_test_and_set_flag(np, OF_POPULATED))
                 return NULL;

of_device_is_available takes a global spinlock and then calls 
__of_device_is_available, and that does:

static bool __of_device_is_available(const struct device_node *device)
{
         const char *status;
         int statlen;

         if (!device)
                 return false;

... so I don't see how this can do anything but immediately return false 
if node is NULL.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
