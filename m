Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B853358117C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237617AbiGZKxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiGZKx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:53:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003F92A26C;
        Tue, 26 Jul 2022 03:53:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LsYfq3p2Jz4xD9;
        Tue, 26 Jul 2022 20:53:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1658832805;
        bh=e0EUedkqhJ1b57DPBaL0yyDtxdDY/BCjyXAIINYG4mw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JRrZkDpTo9+yy3aaV9r4JdVGbVeLe2ATkOknoJ5+p/Xe1iss0Vn1HHVEpgqWhGt72
         mfq3eXbFPINYl3odQGW1kAYXpq4d3Yc2uQRXccgGxOo5C0XNkv+vhZ8faIDlMjX4TT
         gdKewLIUoVToLO3HsCtZrKM4gPedk8eb8Sqez4vHeXCV05idChuzR/hBBO3nLPKUw/
         o+Wc66sMaC9dW7lQhFWp4x0iKwGhNrSLTTCkThYasHOPMFz1RYQoQ/QBfAy3J4FsCH
         oZUiYFaQjZ4IbV//8iHU+MeqnDXbeGk/hMgwxSUA2P85v07bjUi8KUSC8/Jh5aCSxd
         LCjhxqr5dSzsQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Laurent Dufour <ldufour@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, wim@linux-watchdog.org,
        linux@roeck-us.net, nathanl@linux.ibm.com
Cc:     haren@linux.vnet.ibm.com, hch@infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v5 4/4] pseries/mobility: set NMI watchdog factor during
 an LPM
In-Reply-To: <4e366d73-fb9f-bd83-abd0-c624a737a0cd@linux.ibm.com>
References: <20220713154729.80789-1-ldufour@linux.ibm.com>
 <20220713154729.80789-5-ldufour@linux.ibm.com>
 <e6232bb4-a8e5-8f33-e80e-06b1356565b7@infradead.org>
 <4e366d73-fb9f-bd83-abd0-c624a737a0cd@linux.ibm.com>
Date:   Tue, 26 Jul 2022 20:53:21 +1000
Message-ID: <878rogb0wu.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Dufour <ldufour@linux.ibm.com> writes:
> Le 13/07/2022 =C3=A0 22:17, Randy Dunlap a =C3=A9crit=C2=A0:
>> Hi Laurent,
>>=20
>> On 7/13/22 08:47, Laurent Dufour wrote:
>>> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentatio=
n/admin-guide/sysctl/kernel.rst
>>> index ddccd1077462..d73faa619c15 100644
>>> --- a/Documentation/admin-guide/sysctl/kernel.rst
>>> +++ b/Documentation/admin-guide/sysctl/kernel.rst
>>> @@ -592,6 +592,18 @@ to the guest kernel command line (see
>>>  Documentation/admin-guide/kernel-parameters.rst).
>>>=20=20
>>>=20=20
>>> +nmi_wd_lpm_factor (PPC only)
>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>>> +
>>> +Factor apply to the NMI watchdog timeout (only when ``nmi_watchdog`` is
>>=20
>>    Factor to apply to
>
> Thanks, Randy.
>
> Michael, could you fix that when applying the series?

Yes, I did.

cheers
