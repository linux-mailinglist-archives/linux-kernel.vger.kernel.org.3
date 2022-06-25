Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B64755ABBD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 19:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbiFYRZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 13:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiFYRZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 13:25:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A038513CD2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 10:25:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C3F9B8018A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 17:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F92C3411C;
        Sat, 25 Jun 2022 17:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656177953;
        bh=Qbfd2U7GwY8YXWYY3X2tmi1oh3dr4iihOkEXwDFofa4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ICzdIFltNKadYOiJFovZWXRcoS46odzQoHdmfWGcRkbOAhrgPEMZnW4uXUb9W4V0P
         +Xg630oHvYnt4YXoyIrHWnvOZZZaNKRiYvKHGwwCV6OAcRPh4nKh+RJWs1RxzbjlXg
         Xibz6TFHoskE3yNhIVZX/jVyc5SGLTYBr6pQ9BjO/54hEQBn0StIWnoj27ISDeHuzn
         GQ12qbLZte8RMulcNefJrSsRmAf2Ro926bHIYO4ZUpdQOTvjOEM6xNBoOmMC907xmU
         zWjLRpcEz1gcsdpAC9OrLsvmqFFrZcJESszvpB1s/iWu3K6FJNoHwksSOE9GvHVOhV
         bYSjEr2vNSOEw==
Message-ID: <3f1b974be23b058cc0f004b518df21716b9dfcfd.camel@kernel.org>
Subject: Re: [PATCH v6 1/3] tracing: eprobe: remove duplicate is_good_name()
 operation
From:   Tom Zanussi <zanussi@kernel.org>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Sat, 25 Jun 2022 12:25:50 -0500
In-Reply-To: <1655776787-18133-2-git-send-email-quic_linyyuan@quicinc.com>
References: <1655776787-18133-1-git-send-email-quic_linyyuan@quicinc.com>
         <1655776787-18133-2-git-send-email-quic_linyyuan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linyu,

On Tue, 2022-06-21 at 09:59 +0800, Linyu Yuan wrote:
> traceprobe_parse_event_name() already validate SYSTEM and EVENT name,
> there is no need to call is_good_name() after it.
>=20
> Add trace_probe_log_set_index(1) to allow report correct error
> if user input wrong SYSTEM.EVENT format.
>=20
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
> ---
> v2: drop v1 change as it is NACK.
> =C2=A0=C2=A0=C2=A0 add it to remove duplicate is_good_name().
> v3: move it as first patch.
> v4: no change
> v5: add Acked-by tag
> v6: keep is_good_name() check for group and event name
> =C2=A0=C2=A0=C2=A0 add trace_probe_log_set_index(1) to report correct err=
or message.
>=20
> =C2=A0kernel/trace/trace_eprobe.c | 3 +--
> =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/kernel/trace/trace_eprobe.c
> b/kernel/trace/trace_eprobe.c
> index 7d44785..8979cb9e 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -881,13 +881,12 @@ static int __trace_eprobe_create(int argc,
> const char *argv[])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!is_good_name(event) =
|| !is_good_name(group))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto parse_error;
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0trace_probe_log_set_index(1);

Is this something that you noticed missing in the original code and are
adding now?  If so, please make this a separate patch.  Or is this
something that's needed for the new 'generating event name' code?  If
that's the case, please move this to the other patch.

This one should only contain the code related to the duplicate
is_good_name() removal mentioned in the subject.  Or if this really
does belong here, please provide more explanation of why it's needed if
you remove the duplicate is_good_name() code.

Thanks,

Tom

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sys_event =3D argv[1];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D traceprobe_parse_=
event_name(&sys_event, &sys_name,
> buf2,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 sys_event - argv[1]);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret || !sys_name)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto parse_error;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!is_good_name(sys_event) |=
| !is_good_name(sys_name))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0goto parse_error;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&event_mutex);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0event_call =3D find_and_g=
et_event(sys_name, sys_event);

