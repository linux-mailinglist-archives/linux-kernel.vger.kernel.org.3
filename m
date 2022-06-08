Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D948542B7F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbiFHJ0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbiFHJZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:25:28 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-oln040092072063.outbound.protection.outlook.com [40.92.72.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506FB3BA7A;
        Wed,  8 Jun 2022 01:48:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnzLMT+0SgXckdd/Xx10238zYU8av5AoQ7fvhWHMFbAU0g8qD9meNd4wJj0kxkVTI4k8VYvDY1y5ZCdKAzbvcsMjnkvt8ubcx4Jd0UIv/YD5Gylswe9NApO++A4gnddm3YE9vQbszz9taUq2dtwShLC0Y8CPTiIYBimgKQ997zPuFSxS7Sb4eRwMfV+kbl79s8EljKN0R93tw/pGWYQLlfkdTogB4clvZR1Byt07E9rJgB4Pya7HQAoa8KP9ANwI4Gu88Y2ZxnDBIXb98ztshGe7dmsAH2gq9ilZpGEQ56D0bwR4e+5GrqT/9Ip6hmueyIAm812Nr+n+WehXOk/vIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09gjnVFzYjvSZeVyilMwmzrUFV+fxSvm2NKmRVei7/g=;
 b=hxSYZFR4SZmVJ3BJ77nYxoYIR6hgndAuDJL5flY2JJ9RlyhnajjIIprE0JIx+NdB/J9toU75ldTyBCe0wZpqLNnC5QKZfjxsd298ium1dzHAMIqxyum9zwgSDHGQFzsw0kPRopnokpuneC6ROeGuPRbJXc/dqqRutolguCgH2b+OpT/R2DsJuBU5BCrGLNx/fqdBdCmnUWpcY+4An0zSoYoiDIRssNlBdN1rZSObBDHZfs0glNroZA97hnGdUvyPY47yXrMfBnXkQU8vQ94jOZk+pqBx8kCRTCUtDEjVvt/eW3/iQyxTPm/TABllbnD3YFWxJbrBOjGk5VXldlzOmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09gjnVFzYjvSZeVyilMwmzrUFV+fxSvm2NKmRVei7/g=;
 b=MNJEYB4tWPeMJ6Z+SMWfEJu1ovp0t3465Yich4HeDtZDWrDEEL5p5nyZ8/LrcTU9+8W1nkhSAbsa6aGvAo9/L5YJHO/lzaq+PUvld3tkrQjwHPZW5kSjBJ/H99Cc4gfqxYTgAs7G3b/XVwB4ndW83EuYN2IP5uEKGCMZETFGzyPMZQGVVghIjQFJaAcByhIE5lJSO2za0PTXi7CVsFDpinafVko8ft21DEMezMMy9nNwAQwAESseSkMxvGBPTemBZX6ScAafWYV5McP+h0ymIGdIgNs1bb0S+4ndG4UFiDIAttwJ+X2nTV2/wD1P2Z/L2ICFV1VsF5q1b3JqPVnX9w==
Received: from DB6P189MB0568.EURP189.PROD.OUTLOOK.COM (2603:10a6:6:31::16) by
 DB8P189MB0886.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:16c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Wed, 8 Jun 2022 08:48:48 +0000
Received: from DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
 ([fe80::9db9:bba4:f81e:9463]) by DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
 ([fe80::9db9:bba4:f81e:9463%7]) with mapi id 15.20.5332.011; Wed, 8 Jun 2022
 08:48:48 +0000
From:   David Binderman <dcb314@hotmail.com>
To:     "keescook@chromium.org" <keescook@chromium.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: kernel bug report and patch
Thread-Topic: kernel bug report and patch
Thread-Index: AQHYexQYTf79Ad3m9k6s9VJPw/JRfg==
Date:   Wed, 8 Jun 2022 08:48:47 +0000
Message-ID: <DB6P189MB05681E9F4785DF2758B9875B9CA49@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [pQfTnPJTaIpfxNXbkVlWa6hg0JCRjat1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6714d9a-f702-4a1d-de1f-08da492bb40a
x-ms-traffictypediagnostic: DB8P189MB0886:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BnUf4Pvz70SuEydRU8ygOxa+CyBE8g9DLEdx19+PLiLm9T7nqTZnAYPHgTf0s+OBnp9/yEzZG2+fEm8vXZ4qxXNGIR+zhPxCXW5TroSSBG5W9zp7lVVmtEYMR2io0kyn5OuGczIcRM6luZ08dnMnTPG6KCJt9bwoK26HuueSZ5sg1IaUdrBtCjyHveS7/lIPo43+RmU7xxj2yALHDQzCcYN+T6lWC19LFfoOrLx9ORy25ukpGTv7JfzghWmKEBN3033jt808Zy1mg02eF0ioZ5dh59T/TFt1LNdqhpXk1FSlHX8LbXFnpguMSc3/TdFMJXn/85s9x+A3rt3KITx0WX1m33NyPz0GoYgQHajWQcS1A/1efIRMzi2L7emUOtjBXCIRJkdn1kHayfasG9CsZujPSWqTegXzHMI+5ZmG1VCxvVYTP1EfnHfunQZ78axXIyB0USxKJ4WsV6qwNPzsa6f/WBHcpwHdvZUQG1hQ8E3wov1s/7P1p0BeVS1cNQA7F4hkqIT/a7sSFki68wIyCDA1ZYUIyxqj/CjoqwnpAHeXm4Gp6oX8sIzBUvaZx4B9mfBNSC/g1dFPA12ADeyB2Q==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?Qos5/4hvsYNHodHTE6Z5sI3c7we0Xl3zshV8oGvFinBWD7On6MHErRrq?=
 =?Windows-1252?Q?3VZh+FExy1IQJ7eo/hanDHUKsBEwx4ePtTPQoKjJMca+//L3lqbq2nb+?=
 =?Windows-1252?Q?C4nk8HtyxSbNlorA3ZkPHTTmi2xWv2cc9+oLbZpQplp5aJvlFGXlBCQ7?=
 =?Windows-1252?Q?goE76ksN5Ib/qxR+4Mz+Y2MUCdgshc7dvNzr3Zn7vIfzLp7GRy9VqcNC?=
 =?Windows-1252?Q?HksjkYqym+i8yUxz0u17g8OBJduKKgJ+wsQcH2mOElU+BX4rxlZp9il4?=
 =?Windows-1252?Q?KwpF8ZVZai+fuJd4c3u0AJ5hIUEsRN/f2c7cwMzqwY/r2xMf2G41qbTx?=
 =?Windows-1252?Q?tJQbUcFk6DKG/kUn7HKoHcSFBSsT5bhL7yj5MlNb+5fGW0hn4KisoteO?=
 =?Windows-1252?Q?xwwSw2dGgSer7t+gldxwqz1uXU1NzA4qylbuX2XqTpzuUfTHWFsNo+sv?=
 =?Windows-1252?Q?6CGfsnFbq6NA7N7TSl+vo1p1FHtSXCH9K+ltkqe6wxPoxLeHdQoLG/ks?=
 =?Windows-1252?Q?Q2nCPKlTiy7oT88tz/1X7WblIOsrlb4kYA3or7B/AAFhXpCNPdvkhhPH?=
 =?Windows-1252?Q?GSqEeBWoBLoGCZMN0A4dHy80zqdESHjNMO29SoY72jH0GoT21Rz5GPBe?=
 =?Windows-1252?Q?24olucko6LDyBUI7KfdgZV0J6bHKqdBHXPs1WlyomhbJGud2HglHBxfJ?=
 =?Windows-1252?Q?nLwvRvo56hbpY51p5EQN55p5zGWMyQFCzzruezKVIDTNy7zEzQYs2VzZ?=
 =?Windows-1252?Q?ZK9vCDLuwThBmAnDeXEX+BWS7Oi+LUtFFks987ligiWsjtA1cjl0ASsd?=
 =?Windows-1252?Q?JTZXSIpX1Al8wOEJHg3qRVzsjcbSVYgvnl1VZswym4WmfIuYbS3ig6lL?=
 =?Windows-1252?Q?S02X4qQC36TEMjZypEtX8MBIxkaUcFqXRNIuYgi3ewCKu0ZrrPUq6sbM?=
 =?Windows-1252?Q?KvGVAwtNA8hS7TuIKxaFA+sForWf2hLsRe/8y+w+QrVWICTcYdViapDi?=
 =?Windows-1252?Q?Czg+4A4tsChq9W6lqK9gvAop+XhhWtrztRkqyL5de/78gKWf7o4ukuRB?=
 =?Windows-1252?Q?FwVl3IoDzXUPW1xMirUfOxTOffcjALm1c/MPlZfPFHqwuRiVNZlB8pse?=
 =?Windows-1252?Q?nggLVGvQGE1AUc9Qd1LGqI9+W5mHCKTORAFz4uV+0yN0OhKOHdYfdAmy?=
 =?Windows-1252?Q?gOlrforNrR5TB6Cc2r4IpqZffsemaOigfHbv6Lcz4KYnJd3Ul51j2p3+?=
 =?Windows-1252?Q?byXhzcUY7vdWa80w/aAAsM7UVX/X6D47HezJ4vzld4GW7xARlsCQj/6z?=
 =?Windows-1252?Q?ANuniJSsAUJgowzHeckDrMF25PJlFX4nSgIBskQJocdAhDTj6JrnOdqd?=
 =?Windows-1252?Q?dNYFAOdzwWRIjTlUErRjL/jcxpXfcq/6e6ugavitqiVXrxhuMSe49Q9g?=
 =?Windows-1252?Q?O6/yk3jVymoKKyTU2tiIl3hFDakAbVtLS4FIS9de1Yin8UJr2ffwVIjA?=
 =?Windows-1252?Q?ubZqri/IYsokTHgEX8prKl/mQI2S+Q=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c54b5.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a6714d9a-f702-4a1d-de1f-08da492bb40a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 08:48:47.8910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P189MB0886
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there Kees,=0A=
=0A=
I've been trying for the last few weeks to compile recent linux kernels wit=
h=0A=
development versions of gcc, without success.=0A=
=0A=
I keep getting this error:=0A=
=0A=
In file included from scripts/gcc-plugins/gcc-common.h:75,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0from scripts/gcc-plugins/stackleak_plugi=
n.c:30:=0A=
/home/dcb/gcc/results.20220604.asan.ubsan/lib/gcc/x86_64-pc-linux-gnu/13.0.=
0/plugin/include/gimple-fold.h:71:32: error: use of enum =91gsi_iterator_up=
date=92 without previous declaration=0A=
=0A=
I found this patch useful:=0A=
=0A=
*** ../linux-5.18/scripts/gcc-plugins/gcc-common.h	2022-03-20 20:14:17.0000=
=0A=
00000 +0000=0A=
--- scripts/gcc-plugins/gcc-common.h	2022-06-08 09:21:21.693178983 +0100=0A=
***************=0A=
*** 71,76 ****=0A=
--- 71,78 ----=0A=
=A0 #include "varasm.h"=0A=
=A0 #include "stor-layout.h"=0A=
=A0 #include "internal-fn.h"=0A=
+ #include "gimple.h"=0A=
+ #include "gimple-iterator.h"=0A=
=A0 #include "gimple-expr.h"=0A=
=A0 #include "gimple-fold.h"=0A=
=A0 #include "context.h"=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=
