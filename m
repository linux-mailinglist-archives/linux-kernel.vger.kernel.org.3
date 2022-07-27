Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC90582255
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiG0Inq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiG0Ino (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:43:44 -0400
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E9C45F45;
        Wed, 27 Jul 2022 01:43:40 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id WHT00133;
        Wed, 27 Jul 2022 16:43:33 +0800
Received: from Jtjnmail201613.home.langchao.com (10.100.2.13) by
 Jtjnmail201617.home.langchao.com (10.100.2.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Wed, 27 Jul 2022 16:43:34 +0800
Received: from Jtjnmail201613.home.langchao.com ([fe80::b8bf:393:bebe:1197])
 by Jtjnmail201613.home.langchao.com ([fe80::b8bf:393:bebe:1197%12]) with mapi
 id 15.01.2507.009; Wed, 27 Jul 2022 16:43:34 +0800
From:   =?gb2312?B?QW5keSBHdW8gKLn5zsCx8yk=?= <guoweibin@inspur.com>
To:     "b-liu@ti.com" <b-liu@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?gb2312?B?QW5keSBHdW8gKLn5zsCx8yk=?= <guoweibin@inspur.com>
Subject: [PATCH v2] usb: musb: Fix musb_gadget.c rxstate may cause
 request->buf overflow problems
Thread-Topic: [PATCH v2] usb: musb: Fix musb_gadget.c rxstate may cause
 request->buf overflow problems
Thread-Index: AdihlK58/c/eW9hwTTW0SyWnHPS6PQ==
Date:   Wed, 27 Jul 2022 08:43:34 +0000
Message-ID: <200f38d3e3eb44ec8ec8f8e9f210f131@inspur.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.180.162.69]
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
        micalg=SHA1; boundary="----=_NextPart_000_009A_01D8A1D8.01C168D0"
MIME-Version: 1.0
tUid:   20227271643336f712e09a47c5a0103143d9517a653c2
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_009A_01D8A1D8.01C168D0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

From: guoweibin <guoweibin@inspur.com>

when the rxstate function executes the 'goto buffer_aint_mapped' code
branch, it will always copy the fifocnt bytes data to request->buf,
which may cause request->buf out of bounds. for Ethernet-over-USB will
cause skb_over_panic when a packet larger than mtu is recived.

Fix it by add the length check :
fifocnt = min_t(unsigned, request->length - request->actual, fifocnt);

Signed-off-by: guoweibin <guoweibin@inspur.com>
---
 v2:
-fix format error
 drivers/usb/musb/musb_gadget.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 51274b87f46c..4ad5a1f31d7e 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -760,6 +760,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 			musb_writew(epio, MUSB_RXCSR, csr);
 
 buffer_aint_mapped:
+			fifo_count = min_t(unsigned, request->length - request->actual, fifo_count);
 			musb_read_fifo(musb_ep->hw_ep, fifo_count, (u8 *)
 					(request->buf + request->actual));
 			request->actual += fifo_count;

------=_NextPart_000_009A_01D8A1D8.01C168D0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
hkiG9w0BCQ8ENzA1MA4GCCqGSIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAIAwBwYFKw4DAgcwCgYI
KoZIhvcNAwcwHQYDVR0OBBYEFMQsrLB+sPkRXpck2/e+v3MbZSVSMB8GA1UdIwQYMBaAFF5ZA6a0
TFhgkU72HrWlOaYywTVqMIIBDwYDVR0fBIIBBjCCAQIwgf+ggfyggfmGgbpsZGFwOi8vL0NOPUlO
U1BVUi1DQSxDTj1KVENBMjAxMixDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049
U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1ob21lLERDPWxhbmdjaGFvLERDPWNvbT9jZXJ0
aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9uUG9p
bnSGOmh0dHA6Ly9KVENBMjAxMi5ob21lLmxhbmdjaGFvLmNvbS9DZXJ0RW5yb2xsL0lOU1BVUi1D
QS5jcmwwggEpBggrBgEFBQcBAQSCARswggEXMIGxBggrBgEFBQcwAoaBpGxkYXA6Ly8vQ049SU5T
UFVSLUNBLENOPUFJQSxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1D
b25maWd1cmF0aW9uLERDPWhvbWUsREM9bGFuZ2NoYW8sREM9Y29tP2NBQ2VydGlmaWNhdGU/YmFz
ZT9vYmplY3RDbGFzcz1jZXJ0aWZpY2F0aW9uQXV0aG9yaXR5MGEGCCsGAQUFBzAChlVodHRwOi8v
SlRDQTIwMTIuaG9tZS5sYW5nY2hhby5jb20vQ2VydEVucm9sbC9KVENBMjAxMi5ob21lLmxhbmdj
aGFvLmNvbV9JTlNQVVItQ0EuY3J0MEUGA1UdEQQ+MDygJAYKKwYBBAGCNxQCA6AWDBRndW93ZWli
aW5AaW5zcHVyLmNvbYEUZ3Vvd2VpYmluQGluc3B1ci5jb20wDQYJKoZIhvcNAQELBQADggEBAHG7
MvBCm6jp8r5MutquLYG4kFy61gH6nCfHLdgFgSdPXMb+SHfeQ8chc28iTJdnvSx7qEsqiD0iCuyr
dodbNBNHatGxzreWr8C9U3in46Zf2kQKnZJBrOKNYPWlg9jM9Gr/ZboUAFiQBMN1aJ/C/xK3jUQ+
B8JVuvcIV6eO6Unvrwl3UXM6CeP6ovP5zDZhdjR4pR6UgRNHz/93aaOQGD/T76yUiUBBZYCa4Uh9
xmPoVLmBUxuRNc4K+QvpwrjVCMheCepElkZwm/qz8Sya6P5sGag+6rfh4RSYXN+74I2ZgUqjBgaL
MK4Z24DkB4aQBR7GABtrt8mia7MQWw6Vg/oxggOTMIIDjwIBATBwMFkxEzARBgoJkiaJk/IsZAEZ
FgNjb20xGDAWBgoJkiaJk/IsZAEZFghsYW5nY2hhbzEUMBIGCgmSJomT8ixkARkWBGhvbWUxEjAQ
BgNVBAMTCUlOU1BVUi1DQQITfgABHTcueW3y8AfeyAAAAAEdNzAJBgUrDgMCGgUAoIIB+DAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMjA3MjcwODQzMzJaMCMGCSqG
SIb3DQEJBDEWBBTV/fqZ/n0FCgI46XupMBGXE93RCDB/BgkrBgEEAYI3EAQxcjBwMFkxEzARBgoJ
kiaJk/IsZAEZFgNjb20xGDAWBgoJkiaJk/IsZAEZFghsYW5nY2hhbzEUMBIGCgmSJomT8ixkARkW
BGhvbWUxEjAQBgNVBAMTCUlOU1BVUi1DQQITfgABHTcueW3y8AfeyAAAAAEdNzCBgQYLKoZIhvcN
AQkQAgsxcqBwMFkxEzARBgoJkiaJk/IsZAEZFgNjb20xGDAWBgoJkiaJk/IsZAEZFghsYW5nY2hh
bzEUMBIGCgmSJomT8ixkARkWBGhvbWUxEjAQBgNVBAMTCUlOU1BVUi1DQQITfgABHTcueW3y8Afe
yAAAAAEdNzCBkwYJKoZIhvcNAQkPMYGFMIGCMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEARYwCwYJYIZIAWUDBAECMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUr
DgMCGjALBglghkgBZQMEAgMwCwYJYIZIAWUDBAICMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQA1HipVIMFfbT/2xYiZkEiE8DujUYcopv5bBYWBRmTszLONdpl+QtQxjcA0HgnrtrKcdMIl
FX67JqSYNQoXoty0Ou7sp1tB8a+sJhfhNOB+y+4mCGY1mv3z7xldRD10gEPsfTA0m9hECvbgW9k/
3FAt0yng7jf60vsiRn6gh/Q9WK9mLKnn8IbxZjlQYcZANCg+jLuZolhuZ0fhI9XGi/IlNinWSkTI
Ji1Wm5uMvnTbkNKM0IxQQsK+O5clan1FnJMSwO1km8h1ahUuX7U8B/IyYIWciG/fywnFcdby9HX4
E8a4b3ewdLCfSEn2vhmIRZQZNWP/5N/dKABhy/iyPWEBAAAAAAAA

------=_NextPart_000_009A_01D8A1D8.01C168D0--
