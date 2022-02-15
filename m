Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854DE4B759E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242170AbiBORHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:07:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242164AbiBORHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:07:03 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CABFBDE7D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:06:53 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i14so33182709wrc.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=64ujAZGCy+wXFieA5/Bj8ZqtpVN9eii19Jh2KoGa8VQ=;
        b=L2GzMwlPsZ7uQ/GDO30qwxGgBGqGNVBqZLTl0CXEl3tlyoMniWdKzQPzNGWr9Zxt7/
         S5EcncmoO3Vw6GI+9aYAF8XbQ2lw3eyls4FC+lu2pAGfHzvu7Ob9zAEnfKAY55nAZ6d7
         12ZXoaI6kh9hCMmHJKPUPJWRfpf6aZb1MOCaA/opO4hgdQ7V4m3ZtnODWzCIGCLjzaPX
         8pch32l9fJrzyx5tHBR80+hjG6gWW502dJ5O6nBV6jv+wteAuFr6DruQCRQ44Q7mlt0o
         yQp/0bUYoYSK3/5I6s8OVvcmzbUB0SR0uAoaemIRpTrOX7Vp8Q7iZY+iMwRGautRQehC
         2LFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=64ujAZGCy+wXFieA5/Bj8ZqtpVN9eii19Jh2KoGa8VQ=;
        b=CqMIGINtUU1EXO1HVBD4TOekI/EREDoQmpz5M9Sy2vvwtOsal7YPcLeJ68mJOhR+7s
         ZnIihwgO7fXHzk4AdhxgYbcPx0rJcN+K7oH3+SM7n/5t7pzdAtN9KuJS95E145xLuYu3
         rJc+DjE2/uIkZOXgUo7W0bxDLZQUa7VrKOR7gxSpwsBh5pSgBMqySkNkHIKXe78NZmpa
         UYzaU7UzjbICh2zGM7jY3FQTS+A+hpclUywMHRiLKF1kuFIIdYNRdJ524zS6H2iRp0QM
         4+dNKReRJ0PD6epuKsuiyqkfP2Y67FXuE5xRtbFjvoD7/COI6iLkHDMsuDj9u4A+yxFQ
         KUPQ==
X-Gm-Message-State: AOAM532Oqjtn8SHWNu+gl48ibjujIIOqHFhJnUmaNAUwk5DzxtQ2aZ5z
        s/QzNA6foiQDwydQa6Y70ZL3zDzfdk0x/qXvVkxudw==
X-Google-Smtp-Source: ABdhPJxt7DoTqqlSMnPR20BUAU/D51eBUmhuL5qPMitPYI1QjXmZpvB3HO4dQNvSBDK/LIrFk4jiPFqroLEgJdBXdCk=
X-Received: by 2002:a5d:47cf:: with SMTP id o15mr3959105wrc.412.1644944811535;
 Tue, 15 Feb 2022 09:06:51 -0800 (PST)
MIME-Version: 1.0
References: <20220213150234.31602-1-thomas.liu@ucloud.cn> <CA+FuTSdODATw3hSAMv9aZUmJNM8ZE-YP58pr17bO9rGJUgfegw@mail.gmail.com>
 <CFD9B65A-6762-4D9B-ADEB-B4C0B1902E02@ucloud.cn> <CA+FuTSfQOUEyEDnOU8VVZ=STw_ii-hTwyg-cvpcViPkVK4pLUA@mail.gmail.com>
 <42554FCB-9180-4B32-B5CF-6D3236237D99@ucloud.cn> <CAF=yD-+1RSj_o8n5LDOLVyn_dvVQvmDQo5pacSoDFPOR3M2g5g@mail.gmail.com>
 <CANn89i+T=Ny7pfUomSsa1ub77u8LfYtRZPzmp_0-=oWKt0abLg@mail.gmail.com> <CA+FuTSc9ZeuLE7tqNT-GnqHb27SE7UAtVRVsZHR+dV6ua=UKPA@mail.gmail.com>
In-Reply-To: <CA+FuTSc9ZeuLE7tqNT-GnqHb27SE7UAtVRVsZHR+dV6ua=UKPA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 15 Feb 2022 09:06:39 -0800
Message-ID: <CANn89iLtXW-MFJ74UhP4WyC3a60LrevAxddBjJ1nGu78eSG1DQ@mail.gmail.com>
Subject: Re: [PATCH] gso: do not skip outer ip header in case of ipip and net_failover
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Tao Liu <thomas.liu@ucloud.cn>, David Miller <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 7:46 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:

> > Stuffing state in the skb has been a mistake I think.
>
> If we could unwind those skb inner_* fields (and reclaim the skbuff
> space!) that would be fantastic.

Not sure we can easily remove the space, many networking drivers need them,
we probably do not want to dissect packets in their ndo_start_xmit()

>
> Immediately for this bug: perhaps it can be fixed by resetting the
> network_header on the gso skb if segs == NULL. As the offset is stored
> on the stack.

It seems correct. Any other fields we need to take care of ?
