Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221EE56506B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiGDJIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbiGDJIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:08:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6766D5584;
        Mon,  4 Jul 2022 02:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656925690;
        bh=Ie4WOyCa3Nl27ZgUjfIb5DYmP4DXeOJq3h1/Ikk02lQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dnOOmAXv40TiGYhEhHewwnUN+S/oxUHdQX9F/brAN5/4l/Ahnx7mmOE+bWt0H/M1b
         nu46tn3G5d/rz+2M/3hLwsdGXaaZy9B6LEWUpT55kCfVGZi8zGDHERTxexRKQStDgH
         8BopOebIt8pA99TnC1WV88yUiYheQhiF8La24j3U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.69] ([46.223.3.210]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGQj7-1oP26J0iAX-00GoKw; Mon, 04
 Jul 2022 11:08:10 +0200
Message-ID: <51f2142c-f4a0-e608-a9ad-6d7df14e4535@gmx.de>
Date:   Mon, 4 Jul 2022 11:08:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 4/9] serial: core: sanitize RS485 delays read from
 device tree
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <20220703170039.2058202-1-LinoSanfilippo@gmx.de>
 <20220703170039.2058202-5-LinoSanfilippo@gmx.de>
 <CAHp75VdvBfBM3Exm8BhJs7CzDaFwNYc7BLq-sLuwfzYTo4gyCA@mail.gmail.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <CAHp75VdvBfBM3Exm8BhJs7CzDaFwNYc7BLq-sLuwfzYTo4gyCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fivx9dZYK295NyKzYzs2uwB7FeZ9jYwdtxPDXUlAV7CTMiLBbZH
 O9CXxC2C/rL7nP3lzpwv78FMSU9JR3anI0J00J59UDFBDjORHqGBA5luC3dMKrq/jadPtWa
 TqF9UDgCLR2M8buNpsDIDfzvdhLWD2Rt5Ohj1WXstoh8bhkcgEIdZqEw3UYob0rzTtGdjdm
 HarDosBJTascF1AUkHqaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e2kIDIvE8Us=:+b/4nXIkuSJFxjWgeqx+79
 m9jtQF9mK9OSb7puqzv4HBxqmCKqsNaUkshyMd9ilqkywaNttTY1eJv+TtmS/i/VqylcmRAZC
 1RJDLBAdocdtcqj7kTNoU7HT7D9yx4ecceaFqyMIiCUXyfzcTwJB2vcBTL+kf2SHgtDcv/Wal
 /CUVnovE4lvGdXME4d46F97i2QCCCGSTGcFIhoNh01+H+hA86WnwaIwvMyla8kytzlTk18idB
 7hnrvS0CQpOGx0oQmjL57vi7gNsAlJ598voAm57RpvEn2j8dALURETr+6vD3v2KzEtbYDptdB
 Jy8ZcLWgUDQj2LBsscZYQ15P8uTaBqRZmMSROFOHwTuicN9ZQAWwYnfEJD1Bjedg5kxKHKt28
 QL6DN30NXvYhDeAnBAJKUeeR6+NW392YQw//e4kMYnBDT6aFp89o/VxSYz2whyhjcMKjjsIkP
 9P20NLHkJB2ttzHR+Tp7rOFH8nqfdH55ljQZ0EW8qR35B2CWOBpqXPhOrD6fdXYikp4HS9ajW
 H+O+LSyNJvlVPo87VkIYVk5Mkj6fc53+BLs2K2j54YhASDy6NHBeN+BgnJDK8qEoLpu59E+nB
 kl7uM8ZDPuWoZQGaxG4Qw4tuRUUyDd9EsmySby59LRQPcgxYpykT6UtZfju8nS7HlCNMLWq+/
 TUTtHkaT2kGJJo1180kUaqLvHrc7rZ0945LbbN+UR/ILgQXfULMY8IdCMCqJ5Zco4qw/mFzW8
 UiTrWNDiqQZYxFRVC5ilHMHoi0n9HYhBcNs0kSK8BXVooTbzUqtpkXe4JRsHoAjMLjO88Tggo
 YgKH2BOtIEAkaijB5bp3OGgpSi1fD44BkK5fNWO+bmdYd42jh9dyDJhEfLjskOa+PlAYQRgzC
 putwnABfhtRjH3CLGvQKdIKjw73Dp7DcJ9C3M5Zn2j6jHi0hbePmz/Rvl/qZaKtclqWbs3LxK
 D6blVZl1QD0Zs4she11LetgumMBisW3FeUHKsgJf374D9X14kbD23XWJWvdjYpq+WiQiSkFqO
 zIjkjny2RF02R7rFInF0fac9IFOjXidIHprEe79WQO8IHXeLXKztEB3Xg4SshWvIUJiZnCXFy
 YAwc0Rfp9U92Q2N4OhUcQoaCOnaUlo4LlNtAAfiRYC2wcb0xuvsthicPQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03.07.22 20:34, Andy Shevchenko wrote:
> On Sun, Jul 3, 2022 at 7:02 PM Lino Sanfilippo <LinoSanfilippo@gmx.de> w=
rote:
>>
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> When setting the RS485 configuration from userspace via TIOCSRS485 the
>> delays are clamped to 100ms. Make this consistent with the values passe=
d
>> in by means of device tree parameters.
>
> I'm not sure I got it right. Is the values from DT now clampet as well
> as user space does or other way around? In either way the commit
> message misses the explanation why it's not a problem if user
> previously passed bigger values either via user space or via DT,
> because it's an ABI change, right?
>

Values are now clamped to 100 ms if set by userspace via ioctl and
not clamped at all if set by DT. I will improve the commit message
to make this more clear.

Thanks,
Lino
