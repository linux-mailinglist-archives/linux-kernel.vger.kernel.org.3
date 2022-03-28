Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9364E9C72
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242450AbiC1Qol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237488AbiC1Qoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:44:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F3563FD9A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648485776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fmjqOD3BHl74OkWJZQBaV4zUSFxZmdbs1YlkDjt8Mso=;
        b=WLd4yGBbgSKNsuxvSIe1FOCgcpuIWGC3hIwvNTDRCCaxyZt8ZrwERWVUxai5viGdsUiEQD
        CMqX3W+Yz1jpScymtXTEXpFYGF+2raDlD7BMpi7sYJxlQdv5Cv69bXsElxYbs2l+Y2piZI
        FMhTOj/SsFd6w1Zy5OP3tIZhDONz/JQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-YxHSKuANNDClEYBxNkjlNw-1; Mon, 28 Mar 2022 12:42:55 -0400
X-MC-Unique: YxHSKuANNDClEYBxNkjlNw-1
Received: by mail-ej1-f69.google.com with SMTP id h22-20020a1709060f5600b006b11a2d3dcfso7102994ejj.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=fmjqOD3BHl74OkWJZQBaV4zUSFxZmdbs1YlkDjt8Mso=;
        b=S/e6IeMXb1/fktJNpIDFEVELj64+6DxTieoGb4FO4tM8Krq63kdXkRES+opkdGibHh
         jWv345487++8JIDjLBgsMQBXMEupngYgBH5clxjDyUufPOtt6kNM4VyRc+sRdZvojPrc
         ABZEgHcU+f7LPgfjixZeTKdBoh+vQDqWHG2unm76Fz9CgplncSNwEoinCX9s3GRZHqDn
         ni99lUYPCIBNs5MMw3IEZOMDQcq9TbrQ6OjJJvvrJ5OQRXWDnGHjjioHoV/NK2l6jSB7
         2jcpFajcqUra7YnPSJT/qjsFZ14JnKTSvQFTmXWZ7WCAoXZh81u33MUh/+mLX21kZC6Y
         qQwg==
X-Gm-Message-State: AOAM531ryQjNDpGH6X8Sht2VuiNdo0VEzkvHto1W18XIHq67IBR6b3Mu
        akAqDUHDgEMguHCLKWGsKYpjFTaLTLnaWbR8t+4sbe5sLE7trtPv/9sNke8OInF8agc84oAo1hN
        0CEOguKwqA1qqXG8OT4gNq2I3
X-Received: by 2002:a17:906:69d1:b0:6ce:7201:ec26 with SMTP id g17-20020a17090669d100b006ce7201ec26mr29008768ejs.105.1648485767577;
        Mon, 28 Mar 2022 09:42:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKl2T4YNWrX/G/bLyX2wwQvRxTA6uAkjsCaHLi/EPyI7kjYU0rENziBQoKf+YQfsM/0GREpQ==
X-Received: by 2002:a17:906:69d1:b0:6ce:7201:ec26 with SMTP id g17-20020a17090669d100b006ce7201ec26mr29007877ejs.105.1648485757354;
        Mon, 28 Mar 2022 09:42:37 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709063a0500b006da8fa9526esm6164674eje.178.2022.03.28.09.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 09:42:36 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 224592279E0; Mon, 28 Mar 2022 18:42:36 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, Paolo Abeni <pabeni@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "cake@lists.bufferbloat.net" <cake@lists.bufferbloat.net>
Subject: Re: [PATCH net-next] sch_cake: Take into account guideline
 DEF/DGSIC/36 from French Administration
In-Reply-To: <079a3b29-fec7-97c9-19d9-0bd9a17e63f1@csgroup.eu>
References: <356a242a964fabbdf876a18c7640eb6ead6d0e6b.1648468695.git.christophe.leroy@csgroup.eu>
 <87bkxq5bgt.fsf@toke.dk> <079a3b29-fec7-97c9-19d9-0bd9a17e63f1@csgroup.eu>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 28 Mar 2022 18:42:36 +0200
Message-ID: <875yny58qr.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> Le 28/03/2022 =C3=A0 17:43, Toke H=C3=B8iland-J=C3=B8rgensen a =C3=A9crit=
=C2=A0:
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>=20
>>> French Administration has written a guideline that defines additional
>>> DSCP values for use in its networks.
>>=20
>> Huh, that's interesting!
>>=20
>>> Add new CAKE diffserv tables to take those new values into account
>>> and add CONFIG_NET_SCH_CAKE_DGSIC to select those tables instead of
>>> the default ones.
>>=20
>> ...however I don't think we should be including something this
>> special-purpose into the qdisc kernel code, and certainly we shouldn't
>> have a config option that changes the meaning of the existing diffserv
>> keywords!
>
> By the way it doesn't really change meaning. Just enhances it indeed.=20
> Because they are not changing the meaning of existing DSCP codes, just=20
> adding new ones.

Ah, OK, but then it's even easier, you can just add rules for the new
values using the userspace options and let cake select the rest using
the existing code.

>> Rather, this is something that is best specified from userspace; and in
>> fact Cake already has no less than two different ways to do this: the
>> 'fwmark' option, and setting the skb->priority field. Have you tried
>> using those?
>
> No I have not. In fact I'm just discovering the subject after some=20
> people told me "we are contractually required to apply this guideline,=20
> please make sure Linux kernel supports it".
>
> I'll give 'fwmark' and/or skb->priority a try. Is there any=20
> Documentation on that somewhere ?

Both are documented in the tc-cake man page.

-Toke

