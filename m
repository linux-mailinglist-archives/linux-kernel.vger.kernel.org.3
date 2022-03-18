Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091104DD9D0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbiCRMiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiCRMiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:38:01 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD832E044C;
        Fri, 18 Mar 2022 05:36:41 -0700 (PDT)
Received: from [192.168.0.3] (ip5f5aef49.dynamic.kabel-deutschland.de [95.90.239.73])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4DC3E61EA1923;
        Fri, 18 Mar 2022 13:36:38 +0100 (CET)
Content-Type: multipart/mixed; boundary="------------PSgvYZecXr1ufTM0pfUWlKet"
Message-ID: <b9b00e0e-9182-783d-ae30-d67d778ae060@molgen.mpg.de>
Date:   Fri, 18 Mar 2022 13:36:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dell.Client.Kernel@dell.com
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: ucsi_acpi: probe of USBC000:00 fails with ioremap error
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------PSgvYZecXr1ufTM0pfUWlKet
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux folks,


On a Dell Precision 3540, Linux 5.16.12 reports an ioremap error:

     [    0.000000] Linux version 5.16.0-4-amd64 
(debian-kernel@lists.debian.org) (gcc-11 (Debian 11.2.0-18) 11.2.0, GNU 
ld (GNU Binutils for Debian) 2.38) #1 SMP PREEMPT Debian 5.16.12-1 
(2022-03-08)
     [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.16.0-4-amd64 
root=UUID=c9342a55-b747-4442-b2f4-bc03eb7a51cf ro quiet noisapnp 
log_buf_len=2M cryptomgr.notests btusb.enable_autosuspend=y 
random.trust_cpu=on
     […]
     [    0.000000] DMI: Dell Inc. Precision 3540/0M14W7, BIOS 1.15.0 
12/08/2021
     […]
     [   24.230968] videodev: Linux video capture interface: v2.00
     [   24.237747] ioremap error for 0x78e31000-0x78e32000, requested 
0x2, got 0x0
     [   24.238100] ucsi_acpi: probe of USBC000:00 failed with error -12
     […]
     $ sudo more /proc/iomem
     […]
     78a04000-78ea2fff : ACPI Non-volatile Storage
       78e31000-78e31fff : USBC000:00
     […]

This seems to happen on a lot of Dell devices, cf. bug 199741 (ioremap 
error on Dell XPS 9370) [1].


Kind regards,

Paul


[1]: https://bugzilla.kernel.org/show_bug.cgi?id=199741
--------------PSgvYZecXr1ufTM0pfUWlKet
Content-Type: text/plain; charset=UTF-8; name="iomem.txt"
Content-Disposition: attachment; filename="iomem.txt"
Content-Transfer-Encoding: base64

MDAwMDAwMDAtMDAwMDBmZmYgOiBSZXNlcnZlZAowMDAwMTAwMC0wMDA5ZGZmZiA6IFN5c3Rl
bSBSQU0KMDAwOWUwMDAtMDAwOWVmZmYgOiBSZXNlcnZlZAowMDA5ZjAwMC0wMDA5ZmZmZiA6
IFN5c3RlbSBSQU0KMDAwYTAwMDAtMDAwZmZmZmYgOiBSZXNlcnZlZAogIDAwMDAwMDAwLTAw
MDAwMDAwIDogUENJIEJ1cyAwMDAwOjAwCiAgMDAwMDAwMDAtMDAwMDAwMDAgOiBQQ0kgQnVz
IDAwMDA6MDAKICAwMDAwMDAwMC0wMDAwMDAwMCA6IFBDSSBCdXMgMDAwMDowMAogIDAwMDAw
MDAwLTAwMDAwMDAwIDogUENJIEJ1cyAwMDAwOjAwCiAgMDAwMDAwMDAtMDAwMDAwMDAgOiBQ
Q0kgQnVzIDAwMDA6MDAKICAwMDAwMDAwMC0wMDAwMDAwMCA6IFBDSSBCdXMgMDAwMDowMAog
IDAwMDAwMDAwLTAwMDAwMDAwIDogUENJIEJ1cyAwMDAwOjAwCiAgMDAwMDAwMDAtMDAwMDAw
MDAgOiBQQ0kgQnVzIDAwMDA6MDAKICAwMDBhMDAwMC0wMDBkZmZmZiA6IFBDSSBCdXMgMDAw
MDowMAogICAgMDAwYzAwMDAtMDAwZGZmZmYgOiAwMDAwOjAwOjAyLjAKICAwMDBmMDAwMC0w
MDBmZmZmZiA6IFN5c3RlbSBST00KMDAxMDAwMDAtM2ZmZmZmZmYgOiBTeXN0ZW0gUkFNCjQw
MDAwMDAwLTQwM2ZmZmZmIDogUmVzZXJ2ZWQKICA0MDAwMDAwMC00MDNmZmZmZiA6IHBucCAw
MDowMAo0MDQwMDAwMC02ZDg2Y2ZmZiA6IFN5c3RlbSBSQU0KNmQ4NmQwMDAtNmQ4NmRmZmYg
OiBBQ1BJIE5vbi12b2xhdGlsZSBTdG9yYWdlCjZkODZlMDAwLTZkODZlZmZmIDogUmVzZXJ2
ZWQKNmQ4NmYwMDAtNzM2MjhmZmYgOiBTeXN0ZW0gUkFNCjczNjI5MDAwLTczNmIyZmZmIDog
UmVzZXJ2ZWQKNzM2YjMwMDAtNzgyZDhmZmYgOiBTeXN0ZW0gUkFNCjc4MmQ5MDAwLTc4OTg2
ZmZmIDogUmVzZXJ2ZWQKNzg5ODcwMDAtNzhhMDNmZmYgOiBBQ1BJIFRhYmxlcwo3OGEwNDAw
MC03OGVhMmZmZiA6IEFDUEkgTm9uLXZvbGF0aWxlIFN0b3JhZ2UKICA3OGUzMTAwMC03OGUz
MWZmZiA6IFVTQkMwMDA6MDAKNzhlYTMwMDAtN2FiMjJmZmYgOiBSZXNlcnZlZAo3YWIyMzAw
MC03YWNmZWZmZiA6IFVua25vd24gRTgyMCB0eXBlCjdhY2ZmMDAwLTdhY2ZmZmZmIDogU3lz
dGVtIFJBTQo3YWQwMDAwMC03ZjdmZmZmZiA6IFJlc2VydmVkCiAgN2Q4MDAwMDAtN2Y3ZmZm
ZmYgOiBHcmFwaGljcyBTdG9sZW4gTWVtb3J5CjdmODAwMDAwLWVmZmZmZmZmIDogUENJIEJ1
cyAwMDAwOjAwCiAgN2Y4MDAwMDAtN2Y4MDBmZmYgOiAwMDAwOjAwOjE1LjAKICAgIDdmODAw
MDAwLTdmODAwMWZmIDogbHBzc19kZXYKICAgICAgN2Y4MDAwMDAtN2Y4MDAxZmYgOiBpMmNf
ZGVzaWdud2FyZS4wIGxwc3NfZGV2CiAgICA3ZjgwMDIwMC03ZjgwMDJmZiA6IGxwc3NfcHJp
dgogICAgN2Y4MDA4MDAtN2Y4MDBmZmYgOiBpZG1hNjQuMAogICAgICA3ZjgwMDgwMC03Zjgw
MGZmZiA6IGlkbWE2NC4wIGlkbWE2NC4wCiAgN2Y4MDEwMDAtN2Y4MDFmZmYgOiAwMDAwOjAw
OjE1LjEKICAgIDdmODAxMDAwLTdmODAxMWZmIDogbHBzc19kZXYKICAgICAgN2Y4MDEwMDAt
N2Y4MDExZmYgOiBpMmNfZGVzaWdud2FyZS4xIGxwc3NfZGV2CiAgICA3ZjgwMTIwMC03Zjgw
MTJmZiA6IGxwc3NfcHJpdgogICAgN2Y4MDE4MDAtN2Y4MDFmZmYgOiBpZG1hNjQuMQogICAg
ICA3ZjgwMTgwMC03ZjgwMWZmZiA6IGlkbWE2NC4xIGlkbWE2NC4xCiAgN2Y4MDIwMDAtN2Y4
MDJmZmYgOiAwMDAwOjAwOjE5LjAKICAgIDdmODAyMDAwLTdmODAyMWZmIDogbHBzc19kZXYK
ICAgICAgN2Y4MDIwMDAtN2Y4MDIxZmYgOiBpMmNfZGVzaWdud2FyZS4yIGxwc3NfZGV2CiAg
ICA3ZjgwMjIwMC03ZjgwMjJmZiA6IGxwc3NfcHJpdgogIDgwMDAwMDAwLThmZmZmZmZmIDog
MDAwMDowMDowMi4wCiAgOTAwMDAwMDAtYjFmZmZmZmYgOiBQQ0kgQnVzIDAwMDA6MDIKICAg
IDkwMDAwMDAwLWIxZmZmZmZmIDogUENJIEJ1cyAwMDAwOjAzCiAgICAgIDkwMDAwMDAwLWIx
ZmZmZmZmIDogUENJIEJ1cyAwMDAwOjA1CiAgYzAwMDAwMDAtZDAxZmZmZmYgOiBQQ0kgQnVz
IDAwMDA6M2IKICAgIGMwMDAwMDAwLWNmZmZmZmZmIDogMDAwMDozYjowMC4wCiAgICBkMDAw
MDAwMC1kMDFmZmZmZiA6IDAwMDA6M2I6MDAuMAogIGQ0MDAwMDAwLWVhMGZmZmZmIDogUENJ
IEJ1cyAwMDAwOjAyCiAgICBkNDAwMDAwMC1lYTBmZmZmZiA6IFBDSSBCdXMgMDAwMDowMwog
ICAgICBkNDAwMDAwMC1lOWVmZmZmZiA6IFBDSSBCdXMgMDAwMDowNQogICAgICBlOWYwMDAw
MC1lOWZmZmZmZiA6IFBDSSBCdXMgMDAwMDozYQogICAgICAgIGU5ZjAwMDAwLWU5ZjBmZmZm
IDogMDAwMDozYTowMC4wCiAgICAgICAgICBlOWYwMDAwMC1lOWYwZmZmZiA6IHhoY2ktaGNk
CiAgICAgIGVhMDAwMDAwLWVhMGZmZmZmIDogUENJIEJ1cyAwMDAwOjA0CiAgICAgICAgZWEw
MDAwMDAtZWEwM2ZmZmYgOiAwMDAwOjA0OjAwLjAKICAgICAgICAgIGVhMDAwMDAwLWVhMDNm
ZmZmIDogdGh1bmRlcmJvbHQKICAgICAgICBlYTA0MDAwMC1lYTA0MGZmZiA6IDAwMDA6MDQ6
MDAuMAogIGViMDAwMDAwLWViZmZmZmZmIDogMDAwMDowMDowMi4wCiAgZWMwMDAwMDAtZWMw
ZmZmZmYgOiAwMDAwOjAwOjFmLjMKICBlYzEwMDAwMC1lYzFmZmZmZiA6IFBDSSBCdXMgMDAw
MDozYwogICAgZWMxMDAwMDAtZWMxMDNmZmYgOiAwMDAwOjNjOjAwLjAKICAgICAgZWMxMDAw
MDAtZWMxMDNmZmYgOiBudm1lCiAgZWMyMDAwMDAtZWMyZmZmZmYgOiBQQ0kgQnVzIDAwMDA6
M2IKICAgIGVjMjAwMDAwLWVjMjNmZmZmIDogMDAwMDozYjowMC4wCiAgICBlYzI0MDAwMC1l
YzI1ZmZmZiA6IDAwMDA6M2I6MDAuMAogIGVjMzAwMDAwLWVjM2ZmZmZmIDogUENJIEJ1cyAw
MDAwOjAxCiAgICBlYzMwMDAwMC1lYzMwMGZmZiA6IDAwMDA6MDE6MDAuMAogICAgICBlYzMw
MDAwMC1lYzMwMGZmZiA6IHJ0c3hfcGNpCiAgZWM0MDAwMDAtZWM0MWZmZmYgOiAwMDAwOjAw
OjFmLjYKICAgIGVjNDAwMDAwLWVjNDFmZmZmIDogZTEwMDBlCiAgZWM0MjAwMDAtZWM0MmZm
ZmYgOiAwMDAwOjAwOjE0LjAKICAgIGVjNDIwMDAwLWVjNDJmZmZmIDogeGhjaS1oY2QKICBl
YzQzMDAwMC1lYzQzN2ZmZiA6IDAwMDA6MDA6MDQuMAogICAgZWM0MzAwMDAtZWM0MzdmZmYg
OiBwcm9jX3RoZXJtYWwKICBlYzQzODAwMC1lYzQzYmZmZiA6IDAwMDA6MDA6MWYuMwogICAg
ZWM0MzgwMDAtZWM0M2JmZmYgOiBJQ0ggSEQgYXVkaW8KICBlYzQzYzAwMC1lYzQzZmZmZiA6
IDAwMDA6MDA6MTQuMwogICAgZWM0M2MwMDAtZWM0M2ZmZmYgOiBpd2x3aWZpCiAgZWM0NDAw
MDAtZWM0NDFmZmYgOiAwMDAwOjAwOjE0LjIKICBlYzQ0MjAwMC1lYzQ0MjBmZiA6IDAwMDA6
MDA6MWYuNAogIGVjNDQ0MDAwLWVjNDQ0ZmZmIDogMDAwMDowMDoxNi4wCiAgICBlYzQ0NDAw
MC1lYzQ0NGZmZiA6IG1laV9tZQogIGVjNDQ3MDAwLWVjNDQ3ZmZmIDogMDAwMDowMDoxNC4y
CiAgZWM0NDgwMDAtZWM0NDhmZmYgOiAwMDAwOjAwOjEyLjAKICAgIGVjNDQ4MDAwLWVjNDQ4
ZmZmIDogSW50ZWwgUENIIHRoZXJtYWwgZHJpdmVyCiAgZWM0NDkwMDAtZWM0NDlmZmYgOiAw
MDAwOjAwOjA4LjAKZjAwMDAwMDAtZjdmZmZmZmYgOiBQQ0kgTU1DT05GSUcgMDAwMCBbYnVz
IDAwLTdmXQogIGYwMDAwMDAwLWY3ZmZmZmZmIDogUmVzZXJ2ZWQKICAgIGYwMDAwMDAwLWY3
ZmZmZmZmIDogcG5wIDAwOjA2CmZjODAwMDAwLWZlN2ZmZmZmIDogUENJIEJ1cyAwMDAwOjAw
CiAgZmQwMDAwMDAtZmQ2OWZmZmYgOiBwbnAgMDA6MDcKICBmZDZhMDAwMC1mZDZhZmZmZiA6
IElOVDM0QkI6MDAKICAgIGZkNmEwMDAwLWZkNmFmZmZmIDogSU5UMzRCQjowMCBJTlQzNEJC
OjAwCiAgZmQ2YjAwMDAtZmQ2Y2ZmZmYgOiBwbnAgMDA6MDcKICBmZDZkMDAwMC1mZDZkZmZm
ZiA6IElOVDM0QkI6MDAKICAgIGZkNmQwMDAwLWZkNmRmZmZmIDogSU5UMzRCQjowMCBJTlQz
NEJCOjAwCiAgZmQ2ZTAwMDAtZmQ2ZWZmZmYgOiBJTlQzNEJCOjAwCiAgICBmZDZlMDAwMC1m
ZDZlZmZmZiA6IElOVDM0QkI6MDAgSU5UMzRCQjowMAogIGZkNmYwMDAwLWZkZmZmZmZmIDog
cG5wIDAwOjA3CiAgZmUwMDAwMDAtZmUwMTBmZmYgOiBSZXNlcnZlZAogICAgZmUwMTAwMDAt
ZmUwMTBmZmYgOiAwMDAwOjAwOjFmLjUKICBmZTIwMDAwMC1mZTdmZmZmZiA6IHBucCAwMDow
NwpmZWMwMDAwMC1mZWMwMGZmZiA6IFJlc2VydmVkCiAgZmVjMDAwMDAtZmVjMDAzZmYgOiBJ
T0FQSUMgMApmZWQwMDAwMC1mZWQwMDNmZiA6IEhQRVQgMAogIGZlZDAwMDAwLWZlZDAwM2Zm
IDogUE5QMDEwMzowMApmZWQxMDAwMC1mZWQxN2ZmZiA6IHBucCAwMDowNgpmZWQxODAwMC1m
ZWQxOGZmZiA6IHBucCAwMDowNgpmZWQxOTAwMC1mZWQxOWZmZiA6IHBucCAwMDowNgpmZWQy
MDAwMC1mZWQzZmZmZiA6IHBucCAwMDowNgpmZWQ0NTAwMC1mZWQ4ZmZmZiA6IHBucCAwMDow
NgpmZWQ5MDAwMC1mZWQ5MGZmZiA6IGRtYXIwCmZlZDkxMDAwLWZlZDkxZmZmIDogZG1hcjEK
ZmVlMDAwMDAtZmVlMDBmZmYgOiBMb2NhbCBBUElDCiAgZmVlMDAwMDAtZmVlMDBmZmYgOiBS
ZXNlcnZlZApmZjAwMDAwMC1mZmZmZmZmZiA6IFJlc2VydmVkCiAgZmYwMDAwMDAtZmZmZmZm
ZmYgOiBwbnAgMDA6MDcKMTAwMDAwMDAwLTg3YzdmZmZmZiA6IFN5c3RlbSBSQU0KICAyMzJh
MDAwMDAtMjMzNjAxZTNmIDogS2VybmVsIGNvZGUKICAyMzM4MDAwMDAtMjM0MDNjZmZmIDog
S2VybmVsIHJvZGF0YQogIDIzNDIwMDAwMC0yMzQ0YWM0YmYgOiBLZXJuZWwgZGF0YQogIDIz
NGFlMzAwMC0yMzRmZmZmZmYgOiBLZXJuZWwgYnNzCjg3YzgwMDAwMC04N2ZmZmZmZmYgOiBS
QU0gYnVmZmVyCg==

--------------PSgvYZecXr1ufTM0pfUWlKet--
