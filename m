Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156C6596316
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 21:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbiHPTZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 15:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237156AbiHPTZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:25:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7787549C;
        Tue, 16 Aug 2022 12:25:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F24BD61449;
        Tue, 16 Aug 2022 19:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312AAC433C1;
        Tue, 16 Aug 2022 19:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660677937;
        bh=XjTfd+V+GT/DlFSYxIKxS+oQDaAKsyKqTh3uSDGCIeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F/YRjeydG3WfemscVqTTVwYaq0sNyT6+i8ZAPAPCfT1mnEZGash0UOWzLzUVMi8Qq
         9McluBUVZDVBYyEetWmolZyhuDXsf0TlDTYPBQSZqr5BbefjH1LGXrcHOMcjG+auWO
         4RHhWVfVj3txDwkD3PBGrFZsNRACBzaVJoa3DB8OILEaehkBxQX18VIC9yFXIsn8Sx
         Q+Eiior8CZ0wLhABJflnpIy16eDJUbFigcgmi1mcpw9z0RROAUGcKkU+Vmya5gDS/m
         HE+0mpWnMN2WMxjYFDztgkNeEyddbDOu5BmQacKNDoj7333P7ohcNWDSZiwbC0mZZg
         JUBlvH76SH+pg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CD7F64035A; Tue, 16 Aug 2022 16:25:33 -0300 (-03)
Date:   Tue, 16 Aug 2022 16:25:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Mayuresh Chitale <mchitale@ventanamicro.com>, linux@yadro.com,
        Genevieve Chan <genevieve.chan@starfivetech.com>,
        =?iso-8859-1?Q?Jo=E3o_M=E1rio?= Domingos 
        <joao.mario@tecnico.ulisboa.pt>,
        Nikita Shubin <n.shubin@yadro.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Kautuk Consul <kconsul@ventanamicro.com>
Subject: Re: [PATCH v5] perf arch events: riscv sbi firmware std event files
Message-ID: <YvvvLUnVaO+Fvw3U@kernel.org>
References: <20220628114625.166665-1-nikita.shubin@maquefel.me>
 <20220628114625.166665-4-nikita.shubin@maquefel.me>
 <18c8e9c74955c08fdbd631a35c51b30f3cff3cd3.camel@ventanamicro.com>
 <20220811112303.4e5f0566@redslave.neermore.group>
 <Yvas60duFUkSzuz+@kernel.org>
 <20220815162755.7ed970c6@redslave.neermore.group>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815162755.7ed970c6@redslave.neermore.group>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 15, 2022 at 04:27:55PM +0300, Nikita Shubin escreveu:
> > If I get this today it may even get into v6.0. :-)
 
> Well... i missed it :), on the other hand this series depends on 
> https://lkml.org/lkml/2022/7/27/23 
> which hasn't been merged yet.
 
> Just have sent a v6 series.
 
> Thank you for review!

Ok! Hopefully it'll make 6.1 then. :-)

- Arnaldo
