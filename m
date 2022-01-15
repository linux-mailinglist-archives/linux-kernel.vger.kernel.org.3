Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BEE48F5D2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 09:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiAOICP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 03:02:15 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40208 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiAOICO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 03:02:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1A8A60B52;
        Sat, 15 Jan 2022 08:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCAFC36AE3;
        Sat, 15 Jan 2022 08:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642233733;
        bh=0KqPDW57D7RxOoM3/l/LET6IR4OCuIRVN31HdEijEBc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FNqkOME3qI0h702vh6HOoOiWFQqV3fHb+7MMqz3l2jjzgrLesjGFMO8VYor0zOijR
         HJmgi1TaSlPzDBHWFgo2Bw3bRgSrpgkEtLo22j8OJLltXqOQ0Js00ezYUWNpe76mkg
         0IyJwC7WK6fqQuwm1cgFUnVx4+mpkuACLMXFHa3c0P4xfnF5PSmc1uN2mftgeKl5fd
         at72eWMd4kncZtw7Utlf52kuU6sgbSkwWKi0Zmk++VUpvvYA1wljNyWFkdK24WZvV9
         FdzbJExdOEQOJ/iFqWexiSWpQeQuo/yGWgkI5ZzXaNP9yBUe8mJNM7U69ybAwRMyAh
         P3fbjunpZYGfw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211016064210.7ahqfqcvf66wtt66@pali>
References: <20210930095838.28145-1-pali@kernel.org> <20210930095838.28145-4-pali@kernel.org> <163425678347.1688384.10695189000353676651@swboyd.mtv.corp.google.com> <20211015090937.gnt66hgugrhwnkei@pali> <20211015093701.pfvkighxsndj4ujg@pali> <163433494758.1688384.5994009027317282677@swboyd.mtv.corp.google.com> <20211016064210.7ahqfqcvf66wtt66@pali>
Subject: Re: [PATCH v7 3/6] dt-bindings: mvebu-uart: document DT bindings for marvell,armada-3700-uart-clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Marek =?utf-8?q?Beh=C3=BAn?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
To:     Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>
Date:   Sat, 15 Jan 2022 00:02:11 -0800
User-Agent: alot/0.10
Message-Id: <20220115080213.0CCAFC36AE3@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pali Roh=C3=A1r (2021-10-15 23:42:10)
>=20
> If I was designing this driver and DTS bindings I would have choose
> something like this:
>=20
> uart@0x12000 {

Drop the 0x

>     reg =3D <0x12000 0x18>, <0x12200 0x30>;
>     clock-controller {
>         ...
>     };

Drop this node and put whatever properties are inside into the parent
node.

>     serial1 {
>         ...
>         status =3D "disabled";
>     };
>     serial2 {
>         ...
>         status =3D "disabled";
>     };
> };
>=20
> Meaning that 0x12000 node would be 3 subnodes and all registers would be
> defined in top level nodes and would be handled by one driver.
>=20
> This is really how hardware block looks like. But it is not backward
> compatible...

Sounds good to me. I presume we need the serial child nodes so we can
reference them from the stdout-path?
