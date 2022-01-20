Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33594949BB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 09:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359304AbiATInX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 03:43:23 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:46408 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359323AbiATInL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:43:11 -0500
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Thu, 20 Jan
 2022 16:43:05 +0800
Content-Type: multipart/mixed;
        boundary="------------q58WCOKn6neNIicBJ4XYn7xz"
Message-ID: <cc3b971f-c630-4ce2-e6dd-c13bcba89d22@amlogic.com>
Date:   Thu, 20 Jan 2022 16:43:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V6 0/5] Use CCF to describe the UART baud rate clock
Content-Language: en-US
To:     Kevin Hilman <khilman@baylibre.com>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220118030911.12815-1-yu.tu@amlogic.com>
 <7hfspjqrn7.fsf@baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <7hfspjqrn7.fsf@baylibre.com>
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------q58WCOKn6neNIicBJ4XYn7xz
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kevin,
	Thank you very much for your reply.

On 2022/1/20 6:37, Kevin Hilman wrote:
> [ EXTERNAL EMAIL ]
> 
> Hello,
> 
> Yu Tu <yu.tu@amlogic.com> writes:
> 
>> Using the common Clock code to describe the UART baud rate
>> clock makes it easier for the UART driver to be compatible
>> with the baud rate requirements of the UART IP on different
>> meson chips. Add Meson S4 SoC compatible.
> 
> Could you describe how this was tested and on which SoCs?  There seem to
> be some changes in this series that might affect previous SoCs.
> 
For me, the board starts normally and prints. My intention was to add 
the S4 SOC UART compatible, but for the S4 our baud rate clock is 
calculated at 12MHz by default.So a series of changes were made at your 
suggestion.

Since most SoCs are too old, I was able to find all the platforms myself 
such as Meson6, Meson8, Meson8b, GXL and so on. I only tested it with 
G12A and S4.But when I talked to Martin earlier he tried meson8b's log.
The test patch is in the attachment.

I have found that on some boards with this change, the initcall_debug 
Uart driver takes longer to initialize. Running the stty command to 
change the baud rate at the same time may cause a jam.

I'd love to know what else you suggest.

> Thanks,
> 
> Kevin
> 
> 
--------------q58WCOKn6neNIicBJ4XYn7xz
Content-Type: text/plain; charset="UTF-8"; name="g12a-clk-debug-output"
Content-Disposition: attachment; filename="g12a-clk-debug-output"
Content-Transfer-Encoding: base64

77u/IyBjYXQgL3N5cy9rZXJuZWwvZGVidWcvY2xrLy9jbGtfc3VtbWFyeSB8IGhlYWQNCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVuYWJsZSAgcHJlcGFyZSAgcHJvdGVj
dCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZHV0eSAgaGFyZHdhcmUNCiAgIGNs
b2NrICAgICAgICAgICAgICAgICAgICAgICAgICBjb3VudCAgICBjb3VudCAgICBjb3VudCAg
ICAgICAgcmF0ZSAgIGFjY3VyYWN5IHBoYXNlICBjeWNsZSAgICBlbmFibGUNCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiB4dGFsICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgNiAgICAgICAgNiAgICAgICAgMCAgICAyNDAw
MDAwMCAgICAgICAgICAwICAgICAwICA1MDAwMCAgICAgICAgIFkNCiAgICBmZjgwMzAwMC5z
ZXJpYWwjeHRhbF9kaXYgICAgICAgICAgMSAgICAgICAgMSAgICAgICAgMCAgICAxMjAwMDAw
MCAgICAgICAgICAwICAgICAwICA1MDAwMCAgICAgICAgIFkNCiAgICAgICBmZjgwMzAwMC5z
ZXJpYWwjdXNlX3h0YWwgICAgICAgMSAgICAgICAgMSAgICAgICAgMCAgICAxMjAwMDAwMCAg
ICAgICAgICAwICAgICAwICA1MDAwMCAgICAgICAgIFkNCiAgICAgICAgICBmZjgwMzAwMC5z
ZXJpYWwjYmF1ZF9kaXYgICAgICAgMSAgICAgICAgMSAgICAgICAgMCAgICAgIDExNTM4NSAg
ICAgICAgICAwICAgICAwICA1MDAwMCAgICAgICAgIFkNCiAgICBjdHNfb3NjaW4gICAgICAg
ICAgICAgICAgICAgICAgICAgMCAgICAgICAgMCAgICAgICAgMCAgICAyNDAwMDAwMCAgICAg
ICAgICAwICAgICAwICA1MDAwMCAgICAgICAgIFkNCiAgICAgICBnMTJhX2FvX2NlY19wcmUg
ICAgICAgICAgICAgICAgMCAgICAgICAgMCAgICAgICAgMCAgICAyNDAwMDAwMCAgICAgICAg
ICAwICAgICAwICA1MDAwMCAgICAgICAgIE4NCiAgICAgICAgICBnMTJhX2FvX2NlY19kaXYg
ICAgICAgICAgICAgMCAgICAgICAgMCAgICAgICAgMCAgICAgICAzMjc0MiAgICAgICAgICAw
ICAgICAwICA1MDAwMCAgICAgICAgIFkNCg==
--------------q58WCOKn6neNIicBJ4XYn7xz
Content-Type: text/plain; charset="UTF-8"; name="clk-debug-output.txt"
Content-Disposition: attachment; filename="clk-debug-output.txt"
Content-Transfer-Encoding: base64

IyBjYXQgL3N5cy9rZXJuZWwvZGVidWcvY2xrL2Nsa19zdW1tYXJ5IAogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBlbmFibGUgIHByZXBhcmUgIHByb3RlY3QgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGR1dHkgIGhhcmR3YXJlCiAgIGNsb2NrICAgICAgICAg
ICAgICAgICAgICAgICAgICBjb3VudCAgICBjb3VudCAgICBjb3VudCAgICAgICAgcmF0ZSAg
IGFjY3VyYWN5IHBoYXNlICBjeWNsZSAgICBlbmFibGUKLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpbLi4uXQogeHRhbCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDYgICAgICAgIDYgICAgICAgIDIgICAgMjQwMDAwMDAgICAg
ICAgICAgMCAgICAgMCAgNTAwMDAgICAgICAgICBZClsuLi5dCiAgICBjODEwMDRjMC5zZXJp
YWwjeHRhbF9kaXYzICAgICAgICAgMCAgICAgICAgMCAgICAgICAgMCAgICAgODAwMDAwMCAg
ICAgICAgICAwICAgICAwICA1MDAwMCAgICAgICAgIFkKWy4uLl0KICAgIGZpeGVkX3BsbF9k
Y28gICAgICAgICAgICAgICAgICAgICAxICAgICAgICAxICAgICAgICAwICAyNTUwMDAwMDAw
ICAgICAgICAgIDAgICAgIDAgIDUwMDAwICAgICAgICAgWQogICAgICAgZml4ZWRfcGxsICAg
ICAgICAgICAgICAgICAgICAgIDEgICAgICAgIDEgICAgICAgIDAgIDI1NTAwMDAwMDAgICAg
ICAgICAgMCAgICAgMCAgNTAwMDAgICAgICAgICBZClsuLi5dCiAgICAgICAgICBmY2xrX2Rp
djNfZGl2ICAgICAgICAgICAgICAgMSAgICAgICAgMSAgICAgICAgMCAgIDg1MDAwMDAwMCAg
ICAgICAgICAwICAgICAwICA1MDAwMCAgICAgICAgIFkKICAgICAgICAgICAgIGZjbGtfZGl2
MyAgICAgICAgICAgICAgICAyICAgICAgICAyICAgICAgICAwICAgODUwMDAwMDAwICAgICAg
ICAgIDAgICAgIDAgIDUwMDAwICAgICAgICAgWQpbLi4uXQogICAgICAgICAgICAgICAgbXBl
Z19jbGtfc2VsICAgICAgICAgIDEgICAgICAgIDEgICAgICAgIDAgICA4NTAwMDAwMDAgICAg
ICAgICAgMCAgICAgMCAgNTAwMDAgICAgICAgICBZCiAgICAgICAgICAgICAgICAgICBtcGVn
X2Nsa19kaXYgICAgICAgMSAgICAgICAgMSAgICAgICAgMCAgIDE0MTY2NjY2NyAgICAgICAg
ICAwICAgICAwICA1MDAwMCAgICAgICAgIFkKICAgICAgICAgICAgICAgICAgICAgIGNsazgx
ICAgICAgICAgIDE3ICAgICAgIDIwICAgICAgICAwICAgMTQxNjY2NjY3ICAgICAgICAgIDAg
ICAgIDAgIDUwMDAwICAgICAgICAgWQpbLi4uXQogICAgICAgICAgICAgICAgICAgICAgICAg
YzgxMDA0YzAuc2VyaWFsI2NsazgxX2RpdjQgICAgICAgMSAgICAgICAgMSAgICAgICAgMCAg
ICAzNTQxNjY2NiAgICAgICAgICAwICAgICAwICA1MDAwMCAgICAgICAgIFkKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGM4MTAwNGMwLnNlcmlhbCN1c2VfeHRhbCAgICAgICAxICAg
ICAgICAxICAgICAgICAwICAgIDM1NDE2NjY2ICAgICAgICAgIDAgICAgIDAgIDUwMDAwICAg
ICAgICAgWQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYzgxMDA0YzAuc2VyaWFs
I2JhdWRfZGl2ICAgICAgIDEgICAgICAgIDEgICAgICAgIDAgICAgICAxMTUzNjQgICAgICAg
ICAgMCAgICAgMCAgNTAwMDAgICAgICAgICBZCg==
--------------q58WCOKn6neNIicBJ4XYn7xz
Content-Type: text/plain; charset="UTF-8"; name="s4-clk-debug-output"
Content-Disposition: attachment; filename="s4-clk-debug-output"
Content-Transfer-Encoding: base64

77u/IyBjYXQgL3N5cy9rZXJuZWwvZGVidWcvY2xrL2Nsa19zdW1tYXJ5IHwgaGVhZA0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW5hYmxlICBwcmVwYXJlICBwcm90ZWN0
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkdXR5ICBoYXJkd2FyZQ0KICAgY2xv
Y2sgICAgICAgICAgICAgICAgICAgICAgICAgIGNvdW50ICAgIGNvdW50ICAgIGNvdW50ICAg
ICAgICByYXRlICAgYWNjdXJhY3kgcGhhc2UgIGN5Y2xlICAgIGVuYWJsZQ0KLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIHh0YWwgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICA3ICAgICAgICA3ICAgICAgICAwICAgIDI0MDAw
MDAwICAgICAgICAgIDAgICAgIDAgIDUwMDAwICAgICAgICAgWQ0KICAgIGZlMDdhMDAwLnNl
cmlhbCN4dGFsX2RpdiAgICAgICAgICAxICAgICAgICAxICAgICAgICAwICAgIDEyMDAwMDAw
ICAgICAgICAgIDAgICAgIDAgIDUwMDAwICAgICAgICAgWQ0KICAgICAgIGZlMDdhMDAwLnNl
cmlhbCN1c2VfeHRhbCAgICAgICAxICAgICAgICAxICAgICAgICAwICAgIDEyMDAwMDAwICAg
ICAgICAgIDAgICAgIDAgIDUwMDAwICAgICAgICAgWQ0KICAgICAgICAgIGZlMDdhMDAwLnNl
cmlhbCNiYXVkX2RpdiAgICAgICAxICAgICAgICAxICAgICAgICAwICAgICAgOTIzMDc3ICAg
ICAgICAgIDAgICAgIDAgIDUwMDAwICAgICAgICAgWQ0KICAgIGhkY3AyMl9za3BjbGtfbXV4
ICAgICAgICAgICAgICAgICAwICAgICAgICAwICAgICAgICAwICAgIDI0MDAwMDAwICAgICAg
ICAgIDAgICAgIDAgIDUwMDAwICAgICAgICAgWQ0KICAgICAgIGhkY3AyMl9za3BjbGtfZGl2
ICAgICAgICAgICAgICAwICAgICAgICAwICAgICAgICAwICAgIDI0MDAwMDAwICAgICAgICAg
IDAgICAgIDAgIDUwMDAwICAgICAgICAgWQ0KICAgICAgICAgIGhkY3AyMl9za3BjbGtfZ2F0
ZSAgICAgICAgICAwICAgICAgICAwICAgICAgICAwICAgIDI0MDAwMDAwICAgICAgICAgIDAg
ICAgIDAgIDUwMDAwICAgICAgICAgTg0K

--------------q58WCOKn6neNIicBJ4XYn7xz--
