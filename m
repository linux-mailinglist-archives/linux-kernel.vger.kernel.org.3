Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AD85A175D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 19:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239952AbiHYRA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 13:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiHYRAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 13:00:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248BFB14CB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661446848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y+soGbFYo6Y7tq8kK94Evz6p4TFg7nowqVXsDQ2fVs8=;
        b=dMDLT6or6hTkF4vxcEdiJojFd3zK8nC+fZkmV/iBF6w7jl2b9OpXONryVu1fuCENPWCV1F
        x54jHG8lsnjpj+TQxXWMUXNNxSvnDyMLQIHh8vV2tLoEb9S/NTq4R2uZxtCJbBdY2yOgHV
        exnbZVEBX0EmBC0kUES5/N1Cq7bZbIY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-116-WmS7ILeuPzWz8KVKwLVrzw-1; Thu, 25 Aug 2022 13:00:46 -0400
X-MC-Unique: WmS7ILeuPzWz8KVKwLVrzw-1
Received: by mail-qk1-f197.google.com with SMTP id n15-20020a05620a294f00b006b5768a0ed0so17561525qkp.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=y+soGbFYo6Y7tq8kK94Evz6p4TFg7nowqVXsDQ2fVs8=;
        b=5koKSH6zBF5Ugz9mSBPH0MgGq82oJ0F1w+FKwbv0Ei4jXQO7ikEu+6jep/ERWdmBkW
         UlMUE4uW/W7wGqzB0Htbo6M1nHRzjyO0Ny2J3ZyzhjHH/AZ6ByhM0AZiXIT5eT3p/wXC
         bX+jA+SEYqxzz5h7TlS7nTx37u+Hu7z/OXXfwJ4ry8K6DFD9cg9csiXm6jzLO+ZFCrH+
         CwyZWaw02dn1gL2Ptx8I2DEK2bbssnb4Go73gjfWXguhHXS6E9DE9uDCTKYkD0m3cmjm
         MrTLtAznoIThUZuwSl7DMU02p+IS4sr/FsT2WQn7NJ7ikEm4cXqYZeJKVgXQ3KqxsIRt
         WH4Q==
X-Gm-Message-State: ACgBeo2vTeze/BCEeODN+DrlgHX/LNPfwIqafbQ5dPK0ispvp9gKmSI5
        NkebHNPFgbgMlzlqSrP0FP7gQ68JHrAw+wExykgDHJAdgeWa8oKohuLLchm3rJNF+Rj43ps1Q1J
        NCz7GZmrsPyWpP8TkJumWaTQt
X-Received: by 2002:a37:a811:0:b0:6ba:bc14:18ff with SMTP id r17-20020a37a811000000b006babc1418ffmr3676470qke.173.1661446845188;
        Thu, 25 Aug 2022 10:00:45 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7DWj02d8fSQHoIsOpC9DukvkXHIsats+SzarTj67vC8ERW76P2I6i4MdS496M2unDjId1XmQ==
X-Received: by 2002:a37:a811:0:b0:6ba:bc14:18ff with SMTP id r17-20020a37a811000000b006babc1418ffmr3676364qke.173.1661446843892;
        Thu, 25 Aug 2022 10:00:43 -0700 (PDT)
Received: from halaneylaptop ([2600:1700:1ff0:d0e0::48])
        by smtp.gmail.com with ESMTPSA id i8-20020a05620a150800b006b928ba8989sm2565qkk.23.2022.08.25.10.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 10:00:43 -0700 (PDT)
Date:   Thu, 25 Aug 2022 12:00:41 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFT PATCH v2 2/2] regulator: core: Don't err if allow-set-load
 but no allowed-modes
Message-ID: <20220825170041.rgzafcac2r5q2wce@halaneylaptop>
References: <20220824142229.RFT.v2.1.I137e6bef4f6d517be7b081be926059321102fd3d@changeid>
 <20220824142229.RFT.v2.2.I6f77860e5cd98bf5c67208fa9edda4a08847c304@changeid>
 <20220825151427.dux3luxs6sxx5tno@halaneylaptop>
 <CAD=FV=Wf90u_DdczAeOqP8aXTO-CSei+9SGxytwS=M0LA9+w-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=Wf90u_DdczAeOqP8aXTO-CSei+9SGxytwS=M0LA9+w-g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 09:43:45AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Aug 25, 2022 at 8:14 AM Andrew Halaney <ahalaney@redhat.com> wrote:
> >
> > On Wed, Aug 24, 2022 at 02:22:57PM -0700, Douglas Anderson wrote:
> > > Apparently the device trees of some boards have the property
> > > "regulator-allow-set-load" for some of their regulators but then they
> > > don't specify anything for "regulator-allowed-modes". That's not
> > > really legit, but...
> > >
> > > ...before commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
> > > get_optimum_mode(), not set_load()") they used to get away with it, at
> > > least on boards using RPMH regulators. That's because when a regulator
> > > driver implements set_load() then the core doesn't look at
> > > "regulator-allowed-modes" when trying to automatically adjust things
> > > in response to the regulator's load. The core doesn't know what mode
> > > we'll end up in, so how could it validate it?
> > >
> > > Said another way: before commit efb0cb50c427 ("regulator: qcom-rpmh:
> > > Implement get_optimum_mode(), not set_load()") some boards _were_
> > > having the regulator mode adjusted despite listing no allowed
> > > modes. After commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
> > > get_optimum_mode(), not set_load()") these same boards were now
> > > getting an error returned when trying to use their regulators, since
> > > simply enabling a regulator tries to update its load and that was
> > > failing.
> > >
> > > We don't really want to go back to the behavior from before commit
> > > efb0cb50c427 ("regulator: qcom-rpmh: Implement get_optimum_mode(), not
> > > set_load()"). Boards shouldn't have been changing modes if no allowed
> > > modes were listed. However, the behavior after commit efb0cb50c427
> > > ("regulator: qcom-rpmh: Implement get_optimum_mode(), not set_load()")
> > > isn't the best because now boards can't even turn their regulators on.
> > >
> > > Let's choose to detect this case and return "no error" from
> > > drms_uA_update(). The net-result will be _different_ behavior than we
> > > had before commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
> > > get_optimum_mode(), not set_load()"), but this new behavior seems more
> > > correct. If a board truly needed the mode switched then its device
> > > tree should be updated to list the allowed modes.
> > >
> > > Reported-by: Andrew Halaney <ahalaney@redhat.com>
> > > Fixes: efb0cb50c427 ("regulator: qcom-rpmh: Implement get_optimum_mode(), not set_load()")
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >
> > Tested-by: Andrew Halaney <ahalaney@redhat.com>
> >
> > As you made clear in the commit message, a good number of boards will
> > have a change in behavior since efb0cb50c427 ("regulator: qcom-rpmh: Implement
> > get_optimum_mode(), not set_load()") and associated fixes. I agree that
> > these devices are not properly described. Is there any sort of heads up we
> > should give? Just looking at the Qualcomm devicetrees for aarch64, I see all
> > of these are affected:
> >
> >     apq8016-sbc.dts
> >     apq8096-db820c.dts
> >     apq8096-ifc6640.dts
> >     msm8916-alcatel-idol347.dts
> >     msm8916-asus-z00l.dts
> >     msm8916-huawei-g7.dts
> >     msm8916-longcheer-l8150.dts
> >     msm8916-longcheer-l8910.dts
> >     msm8916-samsung-a2015-common.dtsi
> >     msm8916-samsung-j5.dts
> >     msm8916-samsung-serranove.dts
> >     msm8916-wingtech-wt88047.dts
> >     msm8992-lg-bullhead.dtsi
> >     msm8992-xiaomi-libra.dts
> >     msm8994-msft-lumia-octagon.dtsi
> >     msm8994-sony-xperia-kitakami.dtsi
> >     msm8996-sony-xperia-tone.dtsi
> >     msm8996-xiaomi-common.dtsi
> >     msm8998-clamshell.dtsi
> >     msm8998-fxtec-pro1.dts
> >     msm8998-mtp.dts
> >     msm8998-oneplus-common.dtsi
> >     msm8998-sony-xperia-yoshino.dtsi
> >     sa8155p-adp.dts
> >     sa8xxxp-auto-adp.dtsi
> >     sc8280xp-crd.dts
> >     sc8280xp-lenovo-thinkpad-x13s.dts
> >     sda660-inforce-ifc6560.dts
> >     sdm630-sony-xperia-nile.dtsi
> >     sdm660-xiaomi-lavender.dts
> >     sm8150-sony-xperia-kumano.dtsi
> >     sm8250-sony-xperia-edo.dtsi
> >     sm8350-hdk.dts
> 
> True, it would be a good idea to send out fixes. OK, so let's see. We
> can probably get fairly close to seeing who is affected with these
> greps:
> 
> rpmh_users=$(git grep -l -i rpmh -- arch/arm*/boot/dts/qcom)
> set_modes=$(grep -l regulator-allow-set-load ${rpmh_users})
> but_no_allowed_modes=$(grep -l -v regulator-allowed-modes ${set_modes})
> 
> That actually gives a (much)shorter list than yours. Why?
> 
> Ah. Your list includes not just RPMH users but also RPM users. RPM
> users _won't_ be affected. In RPM regulators we don't actually track
> the modes in the kernel--we actually pass the load directly to the
> remote processor and it handles translating that into loads. RPM
> regulators don't even have a way to directly set the mode.
> 
> ...so we only need to fix a small number (7) boards.
> 
> Posting up patches now. OK, the cover letter should show up shortly at:
> 
> https://lore.kernel.org/r/20220825164205.4060647-1-dianders@chromium.org
> 
> -Doug
> 

Thanks for the grep-fu, I didn't even think about RPM vs RPMH,
I will try and review those today!

 - Andrew

