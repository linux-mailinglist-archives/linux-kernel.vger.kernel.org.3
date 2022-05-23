Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D876531DCE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 23:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiEWVbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 17:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiEWVbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 17:31:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95687893E;
        Mon, 23 May 2022 14:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653341487;
        bh=L1yXvKPj03tgXtdi0Z6vcohjXwEcWIHIczflYFGsM4A=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=kRISwuGHKbdS2MGbdPOHKrw1ZUEeqlRcrNpysyGZzipT6WQP0PWN+FNzP5TudRQFG
         MqgxLEt/COwH7q8xUYfNMen/VJBRaVCSAVqv3jIhvSVAk+eGuZGdwHRmlYNQx/mf2z
         LV6MU12stsP39m0cRyOOaA58epA9aw3Ip1cuXcjY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.182.49]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzQkK-1nfpV92vnU-00vSgo; Mon, 23
 May 2022 23:31:27 +0200
Message-ID: <43de5653-7587-3e8e-274c-b2729649d0fd@gmx.de>
Date:   Mon, 23 May 2022 23:31:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 12/30] parisc: Replace regular spinlock with spin_trylock
 on panic path
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-13-gpiccoli@igalia.com>
 <6a7c924a-54a9-c5ea-8a9d-3ea92987b436@gmx.de>
 <0dda86c0-3a54-8c70-d1e7-18bbb4d41bab@igalia.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <0dda86c0-3a54-8c70-d1e7-18bbb4d41bab@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S8C8ggPQAzt2THMCXCJm3DvZjsLOdiXAmmgPthategQkvdDnN69
 zCW1E+F7T3INuitTqNMdFNfBBVGZk1CSobePKVyrah47Rm6eJdFOwV0S3iJmABoepKkLiR8
 WexQ5t0W1Vfmm4+xYttaKUFWU1NVqVrbDohap0z6r0Ul/xUp5t9CsQcAJHl79p7NlBUl/JN
 ZcOmLrMkmD1PXIPLQv7sQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZUMQspFc4ME=:KRRGDrtumXRJDjjD0dvBJl
 G/vXNlgH26JaOIslpu8ec10Z9s0d/6z+DS0BPRtfC/fv/B0+l3F9kP5hFLiq8hOnlEe/qfOOw
 0PML0OIG+y6nFNAmjNSsIjVBlKPtL2ulq0H4JsPza0NLCa+jF0t+zyZkEgr6VSXb4NITrbiJ9
 eBMgy0mATXulbujo17rfMibYvylGY7/TjkoefButNuKTjlpa5Xkc75OXbiM/PHl94Qcujw0V/
 tBVWMar5+i03UP7QVWX1XOGyxlGqPoUl9AjxbqYPRyC0a1ZKXBKKSbdtsGa/qsRNtGC99CN3W
 y5iH782ovLcd7GuzpQ8xLYbMDuHVOQAuo3YVvLsoUav30f29R2nFYYf95wNJat4Ucy0efrJgH
 TkFjk5xQhGiC+2UuXxUb1bNA9zaN1y+hfDU7VI6DVzSyMx2d2aNJ6VRcrMaqldZi2xbSJbylX
 rWoiV6YyA39pYjHjWRcLs93eNW/ibJyKIX02V378NRl15h/r/h5J3Y4bwvkFncNMP41zi6EPI
 /S94B+frU+ljH5f77a3TaitAMHxtVjF3CK+LQIXrWwNITCUPPvnVgdFnDBOeV+8PvpTrAkZHD
 SHgVejcjZLKKzn5KK8n5qXRmBsXSW6MtZ4LaDPXN3i0pzqlwX3F41JlmWl0zuOsLuVW+xUxVU
 +Mfe5CFwGmrmYzKKaWI8v52e8rxhVDlnExo+tZrhDJBXx+nf3Y9onaSzX3lNOXkUKxsY8JU8k
 H7OzaYE2m+0QqR0WiKn1nXXI1+2m3P1BI3MeYMzpDcSFMI8kiiAa8pMqpBeMDlTHf8SzwSVc1
 KVOooIdnXhdHeRWJPLUzBTAEdwVtjvNGzacNgti42mISyD/K8uD5qLYm3DhnVFoJoOXULILST
 E3p83+R9Qz6rMGPBmOW3nTT2dpjpdoZtvPJob+btcLH+xiRxLpzaPQh/ii2oBK7aYJpO+Yb4W
 PrK2fbh5qR+yO1QEw6RV3gcqwpAz2rZ/1/8Ho30ehl6sQRFMX1sCZDhEtl8CY+tBV1D43Opgl
 qgJOSdaysVwLi+OOw9GGnfYdWvXEorjqzye4Z1qYNfhBm+9vchoVQCvHrMfbO8mIsM+zBUD5W
 VVM53tlmaAObbXRPaLV+Ud7i4eymtmNjnfLTwn2vUCiUO5mfwm32QTkMg==
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guilherme,

On 5/23/22 22:40, Guilherme G. Piccoli wrote:
> On 28/04/2022 13:55, Helge Deller wrote:
>> [...]
>> You may add:
>> Acked-by: Helge Deller <deller@gmx.de> # parisc
>
> Hi Helge, do you think would be possible to still pick this one for
> v5.19 or do you prefer to hold for the next release?

Actually, I'd prefer if you push this patch together with the whole
series upstream at once. The patch itself makes not much sense without
your series...

> I'm working on V2, so if it's merged for 5.19 I won't send it again.

Helge
