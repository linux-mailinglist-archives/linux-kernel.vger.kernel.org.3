Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5F4465427
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244103AbhLARnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:43:18 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:54955 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231499AbhLARnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:43:17 -0500
Received: from [192.168.0.2] (ip5f5aea80.dynamic.kabel-deutschland.de [95.90.234.128])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8FCF061EA191E;
        Wed,  1 Dec 2021 18:39:55 +0100 (CET)
Message-ID: <eb6d86eb-d156-d7ac-0965-181719023d51@molgen.mpg.de>
Date:   Wed, 1 Dec 2021 18:39:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Unable to transfer big files to Nokia N9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


For the first time, I wanted to transfer a 2 MB PDF file from a Dell 
Latitude E7250 with Debian sid/unstable with Linux 5.16-rc1 to a Nokia 
N9 (MeeGo/Harmattan). Using the package *bluez-obexd* 5.61-1 and GNOME 
41, the device was found, and paired fine. Then I selected to transfer 
the 2 MB file, and after starting for a second, it timed out after the 
progress bar moves forward ones and failed.

The systemd journal contains:

     obexd[21139]: Transfer(0x56243fe4f790) Error: Timed out waiting for 
response

Testing with a a 5 byte test text file, worked fine. Also testing with a 
Galaly M32, both files were transferred without problems (though slowly 
with 32 KB/s.)

Trying to connect to the device with bluetoothctl failed for me, and the 
journal contained, it failed.

     $ bluetoothctl
     Agent registered
     [bluetooth]# connect 40:98:4E:5B:CE:XX
     Attempting to connect to 40:98:4E:5B:CE:XX
     Failed to connect: org.bluez.Error.Failed

     bluetoothd[21104]: src/service.c:btd_service_connect() a2dp-source 
profile connect failed for 40:98:4E:5B:CE:B3: Protocol not available

As the Nokia N9 was once pretty popular in the Linux community, I am 
pretty sure, it used to work fine in the past, and there is some 
regression. It’d be great, if you could give me some hints how to 
further debug the issue.


Kind regards,

Paul
