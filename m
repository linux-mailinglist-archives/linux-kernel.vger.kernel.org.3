Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906BA599A12
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348090AbiHSKdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347614AbiHSKdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:33:21 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74A32B4;
        Fri, 19 Aug 2022 03:33:14 -0700 (PDT)
Received: (Authenticated sender: contact@artur-rojek.eu)
        by mail.gandi.net (Postfix) with ESMTPA id 40ECBE000B;
        Fri, 19 Aug 2022 10:33:09 +0000 (UTC)
MIME-Version: 1.0
Date:   Fri, 19 Aug 2022 12:33:08 +0200
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Subject: Re: [PATCH 3/4] iio: add helper function for reading channel offset
 in buffer
In-Reply-To: <CAHp75VeierGKV7BqF+y-vxramA4nk24LOSPRxgmjots_amkg-w@mail.gmail.com>
References: <20220817105643.95710-1-contact@artur-rojek.eu>
 <20220817105643.95710-4-contact@artur-rojek.eu>
 <CAHp75VeierGKV7BqF+y-vxramA4nk24LOSPRxgmjots_amkg-w@mail.gmail.com>
Message-ID: <a9b3f2b469e26d13f1c37a6f10373e24@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-19 10:17, Andy Shevchenko wrote:
> On Wed, Aug 17, 2022 at 1:58 PM Artur Rojek <contact@artur-rojek.eu> 
> wrote:
>> 
>> This is useful for consumers that wish to parse raw buffer data.
> 
> ...
> 
>> +int iio_find_channel_offset_in_buffer(struct iio_dev *indio_dev,
>> +                                     const struct iio_chan_spec 
>> *chan,
>> +                                     struct iio_buffer *buffer)
>> +{
>> +       int length, offset = 0;
>> +       unsigned int si;
>> +
>> +       if (chan->scan_index < 0 ||
>> +           !test_bit(chan->scan_index, buffer->scan_mask)) {
>> +               return -EINVAL;
>> +       }
> 
> Have you run checkpatch? The {} are redundant. But personally I would
> split this into two separate conditionals.
I did run checkpatch on it - all patches were ready for submission.
I don't find the {} redundant for multi-line statements, like this one,
and I personally prefer to check conditions that return the same error
type together.
> 
>> +       for (si = 0; si < chan->scan_index; ++si) {
> 
> Just a side crying: where did you, people, get this pre-increment 
> pattern from?!
> 
>> +               if (!test_bit(si, buffer->scan_mask))
>> +                       continue;
> 
> NIH for_each_set_bit()
> 
>> +               length = iio_storage_bytes_for_si(indio_dev, si);
>> +
>> +               /* Account for channel alignment. */
>> +               if (offset % length)
>> +                       offset += length - (offset % length);
>> +               offset += length;
>> +       }
>> +
>> +       return offset;
>> +}
>> +EXPORT_SYMBOL_GPL(iio_find_channel_offset_in_buffer);
> 
> Same Q as per previous patch: IIO namespace?
