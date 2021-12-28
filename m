Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE1D4808C4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 12:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhL1LYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 06:24:15 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:16623 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhL1LYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 06:24:14 -0500
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 28 Dec
 2021 19:24:11 +0800
Content-Type: multipart/mixed;
        boundary="------------pJLNGTZO4iwSOLaQx0LO32SJ"
Message-ID: <36d63dde-6bfc-925b-51ae-ee801dcfa681@amlogic.com>
Date:   Tue, 28 Dec 2021 19:24:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 3/3] tty: serial: meson: add UART driver compatible with
 S4 SoC on-chip
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <20211221071634.25980-1-yu.tu@amlogic.com>
 <20211221071634.25980-4-yu.tu@amlogic.com>
 <CAFBinCB9Fre9Lea2CAm_8o8g1e3o8oX4ZONbN_bhykNXoFHDdQ@mail.gmail.com>
 <e041c9ed-ff42-a7e7-2fc5-03c96cc69a88@amlogic.com>
 <CAFBinCAr=U0BM6O329td6=Nw4oknyKQUgTGtwhq4RdCLdR_H+A@mail.gmail.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <CAFBinCAr=U0BM6O329td6=Nw4oknyKQUgTGtwhq4RdCLdR_H+A@mail.gmail.com>
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------pJLNGTZO4iwSOLaQx0LO32SJ
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi Martin and Jerome，
	Thank you very much for your reply. I have learned a lot from your 
communication.

On 2021/12/28 4:04, Martin Blumenstingl wrote:
> [ EXTERNAL EMAIL ]
> 
> Hello,
> 
> On Mon, Dec 27, 2021 at 7:56 AM Yu Tu <yu.tu@amlogic.com> wrote:
> [...]
>>> Does the new S4 SoC use an external 12MHz XTAL or does it use a 24MHz XTAL?
>>> If there's still a 24MHz XTAL then I think this description is not
>>> correct - at least based on how I understand the UART controller.
>>>
>> The S4 SoC uses 12MHz(UART_EE_A_REG5[27]=0x1,the bit is set in romcode).
>> This register description is the same as the G12A and G12B you know.
> Thank you for this explanation!
> So the problem is that we're not touching bit 26 and bit 27 - and with
> the updated romcode you would not get any serial output since the
> divider is calculated off the wrong clock.
> 
> I agree with Jerome that we shouldn't put a flag in device-tree.
> 
> Also I did some experimenting with Jerome's idea to implement the
> clocks using CCF (common clock framework), see the attached patches.
> It was a bit tricky because some initial clean-ups were needed in the
> serial driver.
> Note: I have only briefly tested this on a 32-bit Meson8m2 SoC, see my
> attached patches and the clk_summary debugfs output.
> In fact, I expect that there are some issues with at least one of the
> patches as the whole bit 26 and bit 27 code is untested.
> 
> Do you see any problems with this patch?
> Could you try to implement CCF support with the idea from the attached
> patches (you don't need to re-use them, I just wrote them to make it
> clearer in our discussion what we're talking about).
> 
I couldn't agree with you more. I have verified it on a 64-bit S4 
platform. Please refer to the attachment for verification output 
information.
I will prepare the second version of patch according to the example 
ideas you provided.
> 
> Best regards,
> Martin
--------------pJLNGTZO4iwSOLaQx0LO32SJ
Content-Type: text/plain; charset="UTF-8"; name="s4-clk-debug-output.txt"
Content-Disposition: attachment; filename="s4-clk-debug-output.txt"
Content-Transfer-Encoding: base64

77u/IyBjYXQgL3N5cy9rZXJuZWwvZGVidWcvY2xrL2Nsa19zdW1tYXJ5IA0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZW5hYmxlICBwcmVwYXJlICBwcm90ZWN0ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBkdXR5ICBoYXJkd2FyZQ0KICAgY2xvY2sgICAg
ICAgICAgICAgICAgICAgICAgICAgIGNvdW50ICAgIGNvdW50ICAgIGNvdW50ICAgICAgICBy
YXRlICAgYWNjdXJhY3kgcGhhc2UgIGN5Y2xlICAgIGVuYWJsZQ0KLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIHh0YWwgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICA3ICAgICAgICA3ICAgICAgICAwICAgIDI0MDAwMDAwICAg
ICAgICAgIDAgICAgIDAgIDUwMDAwICAgICAgICAgWQ0KICAgIGZlMDdhMDAwLnNlcmlhbCN4
dGFsX2RpdjIgICAgICAgICAxICAgICAgICAxICAgICAgICAwICAgIDEyMDAwMDAwICAgICAg
ICAgIDAgICAgIDAgIDUwMDAwICAgICAgICAgWQ0KICAgICAgIGZlMDdhMDAwLnNlcmlhbCN4
dGFsMl9jbGtfc2VsICAgICAgIDEgICAgICAgIDEgICAgICAgIDAgICAgMTIwMDAwMDAgICAg
ICAgICAgMCAgICAgMCAgNTAwMDAgICAgICAgICBZDQogICAgICAgICAgZmUwN2EwMDAuc2Vy
aWFsI3VzZV94dGFsICAgICAgIDEgICAgICAgIDEgICAgICAgIDAgICAgMTIwMDAwMDAgICAg
ICAgICAgMCAgICAgMCAgNTAwMDAgICAgICAgICBZDQogICAgICAgICAgICAgZmUwN2EwMDAu
c2VyaWFsI2JhdWRfZGl2ICAgICAgIDEgICAgICAgIDEgICAgICAgIDAgICAgICA5MjMwNzcg
ICAgICAgICAgMCAgICAgMCAgNTAwMDAgICAgICAgICBZDQogICAgZmUwN2EwMDAuc2VyaWFs
I3h0YWxfZGl2MyAgICAgICAgIDAgICAgICAgIDAgICAgICAgIDAgICAgIDgwMDAwMDAgICAg
ICAgICAgMCAgICAgMCAgNTAwMDAgICAgICAgICBZDQogICAgICAgZmUwN2EwMDAuc2VyaWFs
I3h0YWxfY2xrX3NlbCAgICAgICAwICAgICAgICAwICAgICAgICAwICAgICA4MDAwMDAwICAg
ICAgICAgIDAgICAgIDAgIDUwMDAwICAgICAgICAgWQ0KDQojIA0KIyBzdHR5IC1GIC9kZXYv
dHR5QU1MMCAgMTE1MjAwDQoNCiMgc3R0eSAtRiAvZGV2L3R0eUFNTDAgDQpzcGVlZCAxMTUy
MDAgYmF1ZDsgbGluZSA9IDA7DQppbnRyID0gXkM7IHF1aXQgPSBeXDsgZXJhc2UgPSBePzsg
a2lsbCA9IF5VOyBlb2YgPSBeRDsgZW9sID0gPHVuZGVmPjsNCmVvbDIgPSA8dW5kZWY+OyBz
d3RjaCA9IDx1bmRlZj47IHN0YXJ0ID0gXlE7IHN0b3AgPSBeUzsgc3VzcCA9IF5aOyBycHJu
dCA9IF5SOw0Kd2VyYXNlID0gXlc7IGxuZXh0ID0gXlY7IGZsdXNoID0gXk87IG1pbiA9IDE7
IHRpbWUgPSAwOw0KLWJya2ludCBpeG9mZiAtaW1heGJlbA0K

--------------pJLNGTZO4iwSOLaQx0LO32SJ--
